/// Bir makinedeki tek bir kişisel rekor kaydı (ekranda gösterilen hali).
class PrEntry {
  const PrEntry({required this.weightKg, required this.createdAt});

  final double weightKg;
  final DateTime createdAt;
}
