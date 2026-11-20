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

/// Kullanıcının beslenme profili ve hesaplanan günlük hedefleri.
/// Her kullanıcı için tek satır tutulur (userId benzersiz).
@DataClassName('NutritionProfileRow')
class NutritionProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().unique()();

  // Enum'lar adlarıyla saklanır: 'male', 'moderate', 'lose' gibi.
  TextColumn get gender => text()();
  IntColumn get age => integer()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  TextColumn get activityLevel => text()();
  TextColumn get goal => text()();

  IntColumn get calories => integer()();
  IntColumn get proteinG => integer()();
  IntColumn get carbsG => integer()();
  IntColumn get fatG => integer()();
  DateTimeColumn get updatedAt => dateTime()();
}

@DriftDatabase(tables: [PrRecords, NutritionProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 1: PrRecords
  // 2: NutritionProfiles eklendi
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Eski sürümden gelen cihazlarda sadece yeni tablo oluşturulur;
          // mevcut PR kayıtlarına dokunulmaz.
          if (from < 2) {
            await m.createTable(nutritionProfiles);
          }
        },
      );
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
