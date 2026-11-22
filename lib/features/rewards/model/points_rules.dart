import 'user_stats.dart';

/// Günün ilk turnike girişinde kazanılan puan.
const int dailyVisitPoints = 10;

/// Haftalık hedefe ulaşılan gün verilen ek puan.
const int weeklyGoalBonus = 50;

/// Bir girişin kullanıcı belgesine yazılacak sonucu.
typedef VisitReward = ({
  int points,
  bool goalReached,
  String date,
  String weekKey,
  int weekDays,
});

String _two(int n) => n.toString().padLeft(2, '0');

/// 2026-11-21 -> "2026-11-21" (cihazın yerel tarihi)
String dateKey(DateTime d) => '${d.year}-${_two(d.month)}-${_two(d.day)}';

/// 2026-11-21 -> "2026-W47" (ISO 8601 hafta numarası, hafta pazartesi başlar)
String isoWeekKey(DateTime d) {
  final date = DateTime.utc(d.year, d.month, d.day);
  // ISO kuralı: haftanın perşembesi hangi yıldaysa hafta o yıla aittir.
  final thursday = date.add(Duration(days: DateTime.thursday - date.weekday));
  final week =
      thursday.difference(DateTime.utc(thursday.year, 1, 1)).inDays ~/ 7 + 1;
  return '${thursday.year}-W${_two(week)}';
}

/// Girişte kazanılacak puanı hesaplar. Bugün zaten puan alındıysa null.
VisitReward? visitRewardFor(UserStats stats, DateTime now) {
  final today = dateKey(now);
  // Aynı gün ikinci giriş: puan yok.
  if (stats.lastVisitDate == today) return null;

  final week = isoWeekKey(now);
  // Hafta değiştiyse sayaç sıfırdan başlar.
  final weekDays = stats.weekDaysIn(week) + 1;
  // Sayaç günde en fazla bir arttığı için hedef haftada tek bir güne denk gelir;
  // bonus böylece haftada bir kez verilir.
  final goalReached = weekDays == stats.weeklyGoalDays;

  return (
    points: dailyVisitPoints + (goalReached ? weeklyGoalBonus : 0),
    goalReached: goalReached,
    date: today,
    weekKey: week,
    weekDays: weekDays,
  );
}
