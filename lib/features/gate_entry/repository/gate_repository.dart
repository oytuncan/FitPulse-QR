import 'package:cloud_firestore/cloud_firestore.dart';

import '../../rewards/repository/rewards_repository.dart';
import '../model/gate_result.dart';
import '../model/gym_occupancy.dart';

/// Turnike girişleri ve salon doluluğu için Firestore erişimi.
///
/// Koleksiyonlar:
/// - `gyms/<gymId>`: name, capacity, activeCount
/// - `entries/<otomatik id>`: userId, gymId, enteredAt, exitedAt
/// Giriş puanı (`users/{uid}`) [RewardsRepository] üzerinden aynı
/// transaction'da yazılır.
class GateRepository {
  GateRepository({FirebaseFirestore? firestore, RewardsRepository? rewards})
    : _db = firestore ?? FirebaseFirestore.instance,
      _rewards = rewards ?? RewardsRepository(firestore: firestore);

  final FirebaseFirestore _db;
  final RewardsRepository _rewards;

  DocumentReference<Map<String, dynamic>> _gym(String gymId) =>
      _db.collection('gyms').doc(gymId);

  CollectionReference<Map<String, dynamic>> get _entries =>
      _db.collection('entries');

  /// Salon belgesini canlı dinler.
  /// Belge yoksa ya da bozuksa akışa FirebaseException hatası düşer; akış
  /// kapanmaz, belge düzelince yeniden veri gelir.
  Stream<GymOccupancy> watchGym(String gymId) {
    return _gym(gymId).snapshots().map((snap) {
      final occupancy = snap.exists ? GymOccupancy.tryParse(snap.data()) : null;
      if (occupancy != null) return occupancy;

      // Önbellekten gelen "belge yok" cevabı genelde bağlantı olmadığı içindir.
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: snap.metadata.isFromCache ? 'unavailable' : 'not-found',
      );
    });
  }

  /// Kullanıcının açık girişi yoksa giriş, varsa çıkış yapar.
  Future<GateOutcome> toggleEntry({
    required String userId,
    required String gymId,
  }) async {
    // İstemci SDK'sında transaction içinde sorgu çalıştırılamaz; açık girişi
    // önce sunucudan bul. Çevrimdışıysa burada 'unavailable' hatası alınır.
    final open = await _entries
        .where('userId', isEqualTo: userId)
        .where('gymId', isEqualTo: gymId)
        .where('exitedAt', isNull: true)
        .limit(1)
        .get(const GetOptions(source: Source.server));

    if (open.docs.isEmpty) return _enter(userId: userId, gymId: gymId);
    final result = await _exit(
      gymId: gymId,
      entryRef: open.docs.first.reference,
    );
    return (result: result, pointsEarned: 0);
  }

  Future<GateOutcome> _enter({required String userId, required String gymId}) {
    final gymRef = _gym(gymId);

    return _db.runTransaction((tx) async {
      // Transaction'da önce tüm okumalar, sonra yazmalar yapılmalı.
      final occupancy = GymOccupancy.tryParse((await tx.get(gymRef)).data());
      final stats = await _rewards.readUserInTransaction(tx, userId);

      if (occupancy == null) {
        return (result: GateResult.gymNotFound, pointsEarned: 0);
      }
      // Kapasite transaction içinde kontrol edilir; aynı anda gelen girişler
      // sınırı aşamaz.
      if (occupancy.isFull) {
        return (result: GateResult.gymFull, pointsEarned: 0);
      }

      tx.set(_entries.doc(), {
        'userId': userId,
        'gymId': gymId,
        'enteredAt': FieldValue.serverTimestamp(),
        'exitedAt': null,
      });
      tx.update(gymRef, {'activeCount': occupancy.activeCount + 1});
      // Günün ilk girişiyse puan (ve hedef günüyse bonus) aynı transaction'da.
      final points = _rewards.applyVisitReward(
        tx,
        userId,
        stats,
        DateTime.now(),
      );
      return (result: GateResult.entered, pointsEarned: points);
    });
  }

  Future<GateResult> _exit({
    required String gymId,
    required DocumentReference<Map<String, dynamic>> entryRef,
  }) {
    final gymRef = _gym(gymId);

    return _db.runTransaction((tx) async {
      final occupancy = GymOccupancy.tryParse((await tx.get(gymRef)).data());
      final entry = await tx.get(entryRef);
      if (occupancy == null) return GateResult.gymNotFound;

      // Çıkış başka bir cihazdan zaten yapıldıysa sayacı ikinci kez düşürme.
      if (!entry.exists || entry.data()?['exitedAt'] != null) {
        return GateResult.exited;
      }

      tx.update(entryRef, {'exitedAt': FieldValue.serverTimestamp()});
      // Sayaç 0'ın altına düşmesin.
      if (occupancy.activeCount > 0) {
        tx.update(gymRef, {'activeCount': occupancy.activeCount - 1});
      }
      return GateResult.exited;
    });
  }
}
