import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/utils/firestore_error_message.dart';
import '../model/points_rules.dart';
import '../model/user_stats.dart';
import '../repository/rewards_repository.dart';

/// Kullanıcının canlı puan ve haftalık hedef durumu.
/// Ana Sayfa kartları, Mağaza ve Profil aynı örneği kullanır (MainShell sağlar).
class UserStatsViewModel extends ChangeNotifier {
  UserStatsViewModel({
    required RewardsRepository repository,
    required this.userId,
  }) : _repo = repository {
    _subscription = _repo
        .watchUser(userId)
        .listen(
          (data) {
            stats = data;
            errorMessage = null;
            notifyListeners();
          },
          // Hata akışı kapatmaz; bağlantı gelince yeni veriyle düzelir.
          onError: (Object e) {
            errorMessage = firestoreErrorMessage(e);
            notifyListeners();
          },
        );
  }

  final RewardsRepository _repo;
  final String userId;
  late final StreamSubscription<UserStats> _subscription;

  UserStats? stats;
  String? errorMessage;

  bool get isLoading => stats == null && errorMessage == null;

  int get points => stats?.points ?? 0;

  int get weeklyGoalDays =>
      stats?.weeklyGoalDays ?? UserStats.defaultWeeklyGoalDays;

  /// Bu hafta salona gelinen gün sayısı (hafta değiştiyse 0).
  int get daysThisWeek => stats?.weekDaysIn(isoWeekKey(DateTime.now())) ?? 0;

  /// Haftalık hedefi kaydeder. Başarılıysa null, değilse Türkçe hata döner.
  /// Yeni değer yerel önbellek sayesinde ekranda hemen görünür.
  Future<String?> setWeeklyGoal(int days) async {
    try {
      await _repo.setWeeklyGoal(userId, days);
      return null;
    } catch (e) {
      return firestoreErrorMessage(e);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
