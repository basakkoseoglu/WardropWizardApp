import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ww_app/auth/auth_service.dart';
import 'package:ww_app/components/my_button.dart';
import 'package:ww_app/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  //email ve şifre text controlleri
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  //giriş sayfasına gitmek için dokunun
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  // Boş alan kontrolü
  bool _validateFields(BuildContext context) {
    if (_emailController.text.isEmpty ||
        _pwController.text.isEmpty ||
        _confirmPwController.text.isEmpty) {
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

  // kayıt ol metodu
  void register(BuildContext context) async {
    // kimlik doğrulama
    final authService = AuthService();

    // Boş alan kontrolü
    if (!_validateFields(context)) {
      return;
    }

    // şifreler aynıysa kullanıcıyı oluştur
    if (_pwController.text == _confirmPwController.text) {
      try {
        await authService.signUpWithEmailPassword(
            _emailController.text, _pwController.text);
      } on FirebaseAuthException catch (e) {
        String errorMessage = authService.getErrorMessage(e.code);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hata'),
            content: Text(errorMessage),
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
    } else {
      // şifreler aynı değilse hata mesajı göster
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Hata"),
          content: Text("Şifreler eşleşmiyor!"),
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
                // logo
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
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 211, 157, 169),
                  ),
                  obscureText: true,
                  controller: _pwController,
                ),
                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  hintText: "Lütfen şifrenizi yeniden giriniz.",
                  prefixIcon: Icon(Icons.lock,
                      color: Color.fromARGB(255, 211, 157, 169)),
                  obscureText: true,
                  controller: _confirmPwController,
                ),
                const SizedBox(height: 25),

                // kayıt ol butonu
                MyButton(
                    text: "Kayıt Ol",
                    onTap: () => register(context),
                    color: const Color.fromARGB(255, 134, 62, 78)),
                const SizedBox(height: 75),

                // giriş yapma
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hesabınız var mı?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        " Giriş Yap",
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
