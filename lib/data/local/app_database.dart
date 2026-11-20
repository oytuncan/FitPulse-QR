import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Makinelerdeki kişisel rekor (PR) kayıtları.
class PrRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Firebase uid: aynı telefondaki farklı hesapların kayıtları karışmasın.
  TextColumn get userId => text()();
  TextColumn get machineId => text()();
  RealColumn get weightKg => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [PrRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

/// Veritabanı uygulamanın belgeler klasöründe bir dosyada tutulur;
/// uygulama kapansa da, internet olmasa da veriler kalır.
QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'fitpulse.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
