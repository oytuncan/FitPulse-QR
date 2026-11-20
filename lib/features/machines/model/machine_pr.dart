import 'machine.dart';

/// Bir makinedeki kişisel rekor: en yüksek kilo ve ilk kaldırıldığı tarih.
class MachinePr {
  const MachinePr({
    required this.machine,
    required this.weightKg,
    required this.achievedAt,
  });

  final Machine machine;
  final double weightKg;
  final DateTime achievedAt;
}
