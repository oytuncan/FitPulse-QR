import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore hatasını kullanıcıya gösterilecek Türkçe mesaja çevirir.
/// [notFound], 'not-found' hatasında gösterilecek ekrana özel mesajdır.
String firestoreErrorMessage(
  Object error, {
  String notFound = 'Aradığın kayıt bulunamadı.',
}) {
  if (error is! FirebaseException) return 'Bir hata oluştu, tekrar dene.';

  switch (error.code) {
    case 'unavailable':
      return 'İnternet bağlantısı yok. Bağlantını kontrol edip tekrar dene.';
    case 'permission-denied':
      return 'Bu işlem için iznin yok.';
    case 'unauthenticated':
      return 'Oturumun sona ermiş, lütfen tekrar giriş yap.';
    case 'not-found':
      return notFound;
    case 'deadline-exceeded':
      return 'Sunucu yanıt vermedi, tekrar dene.';
    case 'aborted':
      return 'İşlem şu an tamamlanamadı, tekrar dene.';
    default:
      return 'Bir hata oluştu, tekrar dene.';
  }
}
