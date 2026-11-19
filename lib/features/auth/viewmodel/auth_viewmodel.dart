import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  bool isLoading = false;
  String? errorMessage;

  Stream<User?> get authState => _repo.authState;

  Future<void> submit({
    required String email,
    required String password,
    required bool isLogin,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      if (isLogin) {
        await _repo.signIn(email.trim(), password);
      } else {
        await _repo.register(email.trim(), password);
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = _turkceHata(e.code);
    } catch (_) {
      errorMessage = 'Bir hata oluştu, tekrar dene.';
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() => _repo.signOut();

  String _turkceHata(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-posta ya da şifre hatalı.';
      case 'email-already-in-use':
        return 'Bu e-posta zaten kayıtlı.';
      case 'weak-password':
        return 'Şifre en az 6 karakter olmalı.';
      case 'network-request-failed':
        return 'İnternet bağlantını kontrol et.';
      default:
        return 'Hata: $code';
    }
  }
}