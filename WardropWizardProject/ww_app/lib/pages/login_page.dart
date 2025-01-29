import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ww_app/auth/auth_service.dart';
import 'package:ww_app/components/my_button.dart';
import 'package:ww_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  //email ve şifre text controlleri
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  //kayıt sayfasına gitmek için dokunun
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // Boş alan kontrolü yap
  bool _validateFields(BuildContext context) {
    if (_emailController.text.isEmpty || _pwController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Hata'),
          content: Text('Lütfen boş alanları doldurun.'),
        ),
      );
      return false;
    }
    return true;
  }

  // Giriş metodu
  void login(BuildContext context) async {
    final authService = AuthService();

    // Boş alan kontrolü
    if (!_validateFields(context)) {
      return;
    }

    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    } on FirebaseAuthException catch (e) {
      //firebase hatalarını yakalayıp türkçe mesajı geterrormessage ile alıyoruz
      String errorMessage = authService.getErrorMessage(e.code);
      //hata mesajını göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const SizedBox(height: 20),
                Image.asset('assets/logoo.png', width: 300, height: 300),

                // mesaj yeri
                Text(
                  'Kıyafetlerinizi büyülü bir şekilde düzenleyin 💜',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
                const SizedBox(height: 60),

                // email text field
                MyTextField(
                  hintText: "Lütfen email adresinizi giriniz.",
                  prefixIcon: Icon(Icons.email,
                      color: Color.fromARGB(255, 211, 157, 169)),
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  hintText: "Lütfen şifrenizi giriniz.",
                  prefixIcon: Icon(Icons.lock,
                      color: Color.fromARGB(255, 211, 157, 169)),
                  obscureText: true,
                  controller: _pwController,
                ),
                const SizedBox(height: 25),

                // giriş butonu
                MyButton(
                  text: "Giriş Yap",
                  onTap: () => login(context),
                  color: const Color.fromARGB(255, 134, 62, 78),
                ),
                const SizedBox(height: 75),

                // kayıt olma
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Henüz bir hesabın yok mu?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        " Kayıt ol",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 134, 62, 78)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
