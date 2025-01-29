import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ww_app/auth/login_or_register.dart';
import 'package:ww_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //kullanıcı oturum açtı
          if (snapshot.hasData) {
            return const HomePage();
          }
          //kullanıcı pturum açmamış
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
