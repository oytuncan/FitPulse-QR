import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../model/machine.dart';
import '../model/machine_pr.dart';
import '../model/pr_entry.dart';

/// Kişisel rekor kayıtları. Veritabanına yalnızca bu sınıf üzerinden erişilir.
class PrRepository {
  PrRepository(this._db);

  final AppDatabase _db;

  Future<void> addRecord({
    required String userId,
    required String machineId,
    required double weightKg,
  }) {
    return _db.into(_db.prRecords).insert(
          PrRecordsCompanion.insert(
            userId: userId,
            machineId: machineId,
            weightKg: weightKg,
          ),
        );
  }

  /// Bir makinenin kayıt geçmişi, yeniden eskiye.
  Future<List<PrEntry>> getHistory({
    required String userId,
    required String machineId,
  }) async {
    final rows = await (_db.select(_db.prRecords)
          ..where((r) => r.userId.equals(userId) & r.machineId.equals(machineId))
          ..orderBy([
            (r) => OrderingTerm.desc(r.createdAt),
            (r) => OrderingTerm.desc(r.id),
          ]))
        .get();

    return rows
        .map((r) => PrEntry(weightKg: r.weightKg, createdAt: r.createdAt))
        .toList();
  }

  /// Bir makinedeki en yüksek kilo; kayıt yoksa null.
  Future<double?> getBestWeight({
    required String userId,
    required String machineId,
  }) {
    final maxWeight = _db.prRecords.weightKg.max();
    final query = _db.selectOnly(_db.prRecords)
      ..addColumns([maxWeight])
      ..where(_db.prRecords.userId.equals(userId) &
          _db.prRecords.machineId.equals(machineId));

    return query.map((row) => row.read(maxWeight)).getSingle();
  }

  /// Kullanıcının her makinedeki rekoru (makine başına tek satır),
  /// en yüksek kiloya göre azalan sırada.
  Future<List<MachinePr>> getPersonalRecords({required String userId}) async {
    // Aynı kilo birden çok kez kaldırıldıysa ilk tarih rekor tarihidir.
    final rows = await (_db.select(_db.prRecords)
          ..where((r) => r.userId.equals(userId))
          ..orderBy([
            (r) => OrderingTerm.desc(r.weightKg),
            (r) => OrderingTerm.asc(r.createdAt),
          ]))
        .get();

    // Sıralı listede her makinenin ilk satırı o makinenin rekorudur.
    final records = <String, MachinePr>{};
    for (final r in rows) {
      records.putIfAbsent(
        r.machineId,
        () => MachinePr(
          machine: Machine.fromId(r.machineId),
          weightKg: r.weightKg,
          achievedAt: r.createdAt,
        ),
      );
    }
    return records.values.toList();
  }
}
