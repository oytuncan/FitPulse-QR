import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore hatasını kullanıcıya gösterilecek Türkçe mesaja çevirir.
String firestoreErrorMessage(Object error) {
  if (error is! FirebaseException) return 'Bir hata oluştu, tekrar dene.';

  switch (error.code) {
    case 'unavailable':
      return 'İnternet bağlantısı yok. Bağlantını kontrol edip tekrar dene.';
    case 'permission-denied':
      return 'Bu işlem için iznin yok.';
    case 'unauthenticated':
      return 'Oturumun sona ermiş, lütfen tekrar giriş yap.';
    case 'not-found':
      return 'Salon bilgisi bulunamadı.';
    case 'deadline-exceeded':
      return 'Sunucu yanıt vermedi, tekrar dene.';
    case 'aborted':
      return 'İşlem şu an tamamlanamadı, tekrar dene.';
    default:
      return 'Bir hata oluştu, tekrar dene.';
  }
}
