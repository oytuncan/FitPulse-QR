/// 80.0 -> "80 kg", 82.5 -> "82,5 kg"
String formatKg(double kg) {
  final text = kg == kg.truncateToDouble()
      ? kg.toStringAsFixed(0)
      : kg.toString().replaceAll('.', ',');
  return '$text kg';
}

/// 2026-11-20 14:05 -> "20.11.2026 14:05"
String formatDateTime(DateTime dt) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(dt.day)}.${two(dt.month)}.${dt.year} '
      '${two(dt.hour)}:${two(dt.minute)}';
}
