/// Salondaki bir makine.
class Machine {
  const Machine({required this.id, required this.name});

  final String id;
  final String name;

  static const _qrPrefix = 'fitpulse:machine:';
  static final _validId = RegExp(r'^[a-zA-Z0-9_-]+$');

  /// QR içeriği `fitpulse:machine:<id>` formatındaysa makineyi döndürür,
  /// değilse null.
  static Machine? fromQr(String raw) {
    final text = raw.trim();
    if (!text.startsWith(_qrPrefix)) return null;

    final id = text.substring(_qrPrefix.length);
    if (!_validId.hasMatch(id)) return null;

    return Machine(id: id, name: _nameFromId(id));
  }

  /// "bench-press" -> "Bench Press"
  static String _nameFromId(String id) {
    return id
        .split(RegExp(r'[-_]'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
