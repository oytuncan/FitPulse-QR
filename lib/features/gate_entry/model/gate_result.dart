/// Turnike QR'ı okutulduktan sonra transaction'ın sonucu.
enum GateResult {
  entered,
  exited,

  /// Salon kapasiteye ulaştı, giriş yapılmadı.
  gymFull,

  /// Salon belgesi yok ya da alanları hatalı.
  gymNotFound,
}
