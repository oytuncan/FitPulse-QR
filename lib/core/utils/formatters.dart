/// 80.0 -> "80", 82.5 -> "82,5" (Türkçe ondalık virgül)
String formatDecimal(double value) {
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toString().replaceAll('.', ',');
}

/// 80.0 -> "80 kg", 82.5 -> "82,5 kg"
String formatKg(double kg) => '${formatDecimal(kg)} kg';

/// 2026-11-20 14:05 -> "20.11.2026 14:05"
String formatDateTime(DateTime dt) {
  String two(int n) => n.toString().padLeft(2, '0');
  return '${two(dt.day)}.${two(dt.month)}.${dt.year} '
      '${two(dt.hour)}:${two(dt.minute)}';
}
