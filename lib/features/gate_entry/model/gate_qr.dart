/// Turnike QR kodu: `fitpulse:gate:<gymId>` (örn. `fitpulse:gate:main`).
class GateQr {
  const GateQr(this.gymId);

  final String gymId;

  static const _qrPrefix = 'fitpulse:gate:';
  static final _validId = RegExp(r'^[a-zA-Z0-9_-]+$');

  /// İçerik turnike formatındaysa [GateQr], değilse null döndürür.
  static GateQr? fromQr(String raw) {
    final text = raw.trim();
    if (!text.startsWith(_qrPrefix)) return null;

    final id = text.substring(_qrPrefix.length);
    if (!_validId.hasMatch(id)) return null;

    return GateQr(id);
  }
}
