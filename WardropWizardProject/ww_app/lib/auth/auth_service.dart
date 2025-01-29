import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Firebase kimlik doğrulama örneği
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase hata kodlarına göre Türkçe mesajlar dönen fonksiyon
  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'Geçersiz email adresi. Lütfen doğru bir email giriniz.';
      case 'user-disabled':
        return 'Bu kullanıcı devre dışı bırakılmış.';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı. Lütfen kayıt olun.';
      case 'wrong-password':
        return 'Hatalı şifre. Lütfen tekrar deneyin.';
      case 'email-already-in-use':
        return 'Bu email adresi zaten kullanılıyor.';
      case 'weak-password':
        return 'Şifre çok zayıf. Daha güçlü bir şifre deneyin.';
      default:
        return 'Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.';
    }
  }

  // Giriş yapmak
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Hata kodunu Türkçe mesajla fırlat
      throw Exception(getErrorMessage(e.code));
    }
  }

  // Üye olmak
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Hata kodunu Türkçe mesajla fırlat
      throw Exception(getErrorMessage(e.code));
    }
  }

  // Oturumu kapatmak
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
