/// Ödül talebi transaction'ının sonucu.
enum RedeemResult {
  success,

  /// Puan yetmedi; hiçbir şey yazılmadı.
  insufficientPoints,

  /// Ödül belgesi silinmiş ya da hatalı.
  rewardNotFound,
}
