/// Kullanıcının puan ve haftalık hedef bilgisi (`users/{uid}` belgesi).
class UserStats {
  const UserStats({
    this.points = 0,
    this.weeklyGoalDays = defaultWeeklyGoalDays,
    this.weekKey,
    this.weekDays = 0,
    this.lastVisitDate,
  });

  static const defaultWeeklyGoalDays = 3;
  static const minWeeklyGoalDays = 1;
  static const maxWeeklyGoalDays = 7;

  final int points;
  final int weeklyGoalDays;

  /// Sayacın ait olduğu ISO hafta, örn. "2026-W47".
  final String? weekKey;

  /// [weekKey] haftasında salona gelinen gün sayısı.
  final int weekDays;

  /// Son giriş günü, örn. "2026-11-21".
  final String? lastVisitDate;

  /// Belge yoksa (henüz hiç puan kazanılmadıysa) varsayılan değerler.
  factory UserStats.fromMap(Map<String, dynamic>? data) {
    if (data == null) return const UserStats();

    int readInt(String key, int fallback) {
      final value = data[key];
      return value is num ? value.toInt() : fallback;
    }

    return UserStats(
      points: readInt('points', 0),
      weeklyGoalDays: readInt(
        'weeklyGoalDays',
        defaultWeeklyGoalDays,
      ).clamp(minWeeklyGoalDays, maxWeeklyGoalDays),
      weekKey: data['weekKey'] as String?,
      weekDays: readInt('weekDays', 0),
      lastVisitDate: data['lastVisitDate'] as String?,
    );
  }

  /// Bu haftaki gün sayısı. Kayıtlı sayaç eski bir haftaya aitse 0.
  int weekDaysIn(String currentWeekKey) =>
      weekKey == currentWeekKey ? weekDays : 0;
}
