/// Turnike QR'ı okutulduktan sonra transaction'ın sonucu.
enum GateResult {
  entered,
  exited,

  /// Salon kapasiteye ulaştı, giriş yapılmadı.
  gymFull,

  /// Salon belgesi yok ya da alanları hatalı.
  gymNotFound,
}

/// Turnike sonucu ve girişte kazanılan puan (çıkışta ve tekrar girişte 0).
typedef GateOutcome = ({GateResult result, int pointsEarned});
