import '../../gate_entry/model/gate_qr.dart';
import '../model/machine.dart';

/// Bir QR okumasının sonucu.
sealed class ScanResult {
  const ScanResult();
}

class ValidScan extends ScanResult {
  const ValidScan(this.machine);
  final Machine machine;
}

/// Turnike QR'ı okundu: makine detayı yerine giriş/çıkış akışı.
class GateScan extends ScanResult {
  const GateScan(this.gate);
  final GateQr gate;
}

class InvalidScan extends ScanResult {
  const InvalidScan();
}

/// Yok sayılacak okuma (meşgulken ya da aynı geçersiz kod tekrar gelince).
class IgnoredScan extends ScanResult {
  const IgnoredScan();
}

/// QR okuma mantığı. Ekranı yeniden çizmesi gereken bir durum tutmadığı için
/// ChangeNotifier değil; ekranın State'i sahiplenir.
class MachineScanViewModel {
  bool _isBusy = false;
  String? _lastInvalid;
  DateTime _lastInvalidAt = DateTime(0);

  static const _invalidCooldown = Duration(seconds: 2);

  ScanResult handleScan(String? raw) {
    // Kamera aynı kodu saniyede birçok kez algılar; meşgulken hepsini yok say.
    if (_isBusy || raw == null || raw.isEmpty) return const IgnoredScan();

    final machine = Machine.fromQr(raw);
    if (machine != null) {
      _isBusy = true;
      return ValidScan(machine);
    }

    final gate = GateQr.fromQr(raw);
    if (gate != null) {
      _isBusy = true;
      return GateScan(gate);
    }

    // Aynı geçersiz kod kısa süre içinde tekrar gelirse mesajı tekrarlama.
    final now = DateTime.now();
    if (raw == _lastInvalid &&
        now.difference(_lastInvalidAt) < _invalidCooldown) {
      return const IgnoredScan();
    }
    _lastInvalid = raw;
    _lastInvalidAt = now;
    return const InvalidScan();
  }

  /// Detay ekranından dönünce ya da turnike işlemi bitince yeni okumalara
  /// izin ver.
  void resume() {
    _isBusy = false;
  }
}
