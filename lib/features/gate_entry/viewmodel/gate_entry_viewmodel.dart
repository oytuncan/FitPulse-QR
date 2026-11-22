import 'package:flutter/foundation.dart';

import '../../../core/utils/firestore_error_message.dart';
import '../../rewards/model/points_rules.dart';
import '../model/gate_result.dart';
import '../repository/gate_repository.dart';

/// Turnike okumasından sonra kullanıcıya gösterilecek mesaj.
typedef GateMessage = ({String text, bool isError});

/// Turnike QR'ı ile giriş/çıkış akışı. Tara ekranının State'i sahiplenir.
class GateEntryViewModel extends ChangeNotifier {
  GateEntryViewModel({required GateRepository repository, required this.userId})
    : _repo = repository;

  final GateRepository _repo;
  final String userId;

  bool isProcessing = false;

  String? _lastGymId;
  DateTime _lastHandledAt = DateTime(0);

  /// Aynı turnike QR'ı bu süre içinde tekrar okunursa yok sayılır;
  /// böylece kamera kodu görmeye devam etse de çift sayım olmaz.
  static const _repeatCooldown = Duration(seconds: 5);

  /// Giriş ya da çıkış yapar. Okuma yok sayıldıysa null döner.
  Future<GateMessage?> handleGate(String gymId) async {
    final now = DateTime.now();
    final isRepeat =
        gymId == _lastGymId && now.difference(_lastHandledAt) < _repeatCooldown;
    if (isProcessing || isRepeat) return null;

    isProcessing = true;
    notifyListeners();
    try {
      final outcome = await _repo.toggleEntry(userId: userId, gymId: gymId);
      return _messageFor(outcome);
    } catch (e) {
      return (
        text: firestoreErrorMessage(e, notFound: 'Salon bilgisi bulunamadı.'),
        isError: true,
      );
    } finally {
      // Bekleme süresi işlem bittikten sonra başlar.
      _lastGymId = gymId;
      _lastHandledAt = DateTime.now();
      isProcessing = false;
      notifyListeners();
    }
  }

  GateMessage _messageFor(GateOutcome outcome) {
    final points = outcome.pointsEarned;
    switch (outcome.result) {
      case GateResult.entered:
        if (points > dailyVisitPoints) {
          return (
            text: 'Giriş yapıldı. Haftalık hedefine ulaştın, +$points puan!',
            isError: false,
          );
        }
        if (points > 0) {
          return (text: 'Giriş yapıldı. +$points puan!', isError: false);
        }
        return (text: 'Giriş yapıldı. İyi antrenmanlar!', isError: false);
      case GateResult.exited:
        return (text: 'Çıkış yapıldı. Görüşmek üzere!', isError: false);
      case GateResult.gymFull:
        return (
          text: 'Salon şu an dolu. Lütfen biraz sonra tekrar dene.',
          isError: true,
        );
      case GateResult.gymNotFound:
        return (text: 'Salon bilgisi bulunamadı.', isError: true);
    }
  }

  // Ekran kapandıktan sonra biten istek hata vermesin.
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
