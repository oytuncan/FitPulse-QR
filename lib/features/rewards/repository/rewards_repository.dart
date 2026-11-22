import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/points_rules.dart';
import '../model/redeem_result.dart';
import '../model/redemption.dart';
import '../model/reward.dart';
import '../model/user_stats.dart';

/// Puan, haftalık hedef ve mağaza için Firestore erişimi.
///
/// Koleksiyonlar:
/// - `users/{uid}`: points, weeklyGoalDays, weekKey, weekDays, lastVisitDate,
///   updatedAt
/// - `rewards/{id}`: name, description, costPoints (sadece okunur)
/// - `redemptions/{id}`: userId, rewardId, rewardName, costPoints, createdAt,
///   status
class RewardsRepository {
  RewardsRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  DocumentReference<Map<String, dynamic>> _user(String uid) =>
      _db.collection('users').doc(uid);

  CollectionReference<Map<String, dynamic>> get _rewards =>
      _db.collection('rewards');

  CollectionReference<Map<String, dynamic>> get _redemptions =>
      _db.collection('redemptions');

  /// Kullanıcı belgesini canlı dinler; belge yoksa varsayılanlar (0 puan).
  Stream<UserStats> watchUser(String uid) =>
      _user(uid).snapshots().map((snap) => UserStats.fromMap(snap.data()));

  /// Ödüller, puan bedeline göre artan sırada.
  Stream<List<Reward>> watchRewards() {
    return _rewards
        .orderBy('costPoints')
        .snapshots()
        .map(
          (query) => query.docs
              .map((doc) => Reward.tryParse(doc.id, doc.data()))
              .nonNulls
              .toList(),
        );
  }

  /// Kullanıcının talepleri, yeniden eskiye.
  /// Bileşik indeks gerekmesin diye sıralama uygulamada yapılır.
  Stream<List<Redemption>> watchRedemptions(String uid) {
    return _redemptions.where('userId', isEqualTo: uid).snapshots().map((
      query,
    ) {
      final list = query.docs
          .map((doc) => Redemption.fromMap(doc.id, doc.data()))
          .toList();
      // Sunucu saati henüz gelmemiş (createdAt null) talep en yenisidir.
      final newest = DateTime(9999);
      list.sort(
        (a, b) => (b.createdAt ?? newest).compareTo(a.createdAt ?? newest),
      );
      return list;
    });
  }

  /// Ödül talep eder: puan transaction içinde kontrol edilip düşülür.
  Future<RedeemResult> redeem({
    required String userId,
    required String rewardId,
  }) {
    final userRef = _user(userId);
    final rewardRef = _rewards.doc(rewardId);

    return _db.runTransaction((tx) async {
      final rewardSnap = await tx.get(rewardRef);
      final stats = UserStats.fromMap((await tx.get(userRef)).data());

      // Bedel sunucudaki ödül belgesinden okunur, ekrandaki değerden değil.
      final reward = Reward.tryParse(rewardSnap.id, rewardSnap.data());
      if (reward == null) return RedeemResult.rewardNotFound;
      // Puan yetmiyorsa hiçbir şey yazılmaz.
      if (stats.points < reward.costPoints) {
        return RedeemResult.insufficientPoints;
      }

      tx.set(userRef, {
        'points': stats.points - reward.costPoints,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      tx.set(_redemptions.doc(), {
        'userId': userId,
        'rewardId': reward.id,
        'rewardName': reward.name,
        'costPoints': reward.costPoints,
        'createdAt': FieldValue.serverTimestamp(),
        'status': Redemption.pendingStatus,
      });
      return RedeemResult.success;
    });
  }

  /// Haftalık hedef gün sayısını kaydeder (1-7).
  Future<void> setWeeklyGoal(String uid, int days) {
    return _user(uid).set({
      'weeklyGoalDays': days,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ---- Turnike giriş transaction'ı için yardımcılar ----

  /// Transaction içinde kullanıcı belgesini okur.
  Future<UserStats> readUserInTransaction(Transaction tx, String uid) async =>
      UserStats.fromMap((await tx.get(_user(uid))).data());

  /// Transaction içinde giriş puanını yazar; kazanılan puanı döndürür
  /// (0 = bugün zaten puan alınmış). Firestore kuralı gereği tüm okumalardan
  /// sonra çağrılmalı.
  int applyVisitReward(
    Transaction tx,
    String uid,
    UserStats stats,
    DateTime now,
  ) {
    final reward = visitRewardFor(stats, now);
    if (reward == null) return 0;

    tx.set(_user(uid), {
      'points': stats.points + reward.points,
      // Belge ilk kez oluşuyorsa varsayılan hedef de yazılsın.
      'weeklyGoalDays': stats.weeklyGoalDays,
      'weekKey': reward.weekKey,
      'weekDays': reward.weekDays,
      'lastVisitDate': reward.date,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return reward.points;
  }
}
