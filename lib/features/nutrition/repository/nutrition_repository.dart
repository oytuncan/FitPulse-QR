import 'package:drift/drift.dart';

import '../../../data/local/app_database.dart';
import '../model/nutrition_profile.dart';

/// Beslenme profili. Veritabanına yalnızca bu sınıf üzerinden erişilir.
class NutritionRepository {
  NutritionRepository(this._db);

  final AppDatabase _db;

  /// Kullanıcının kayıtlı profili; yoksa null.
  Future<NutritionProfile?> getProfile(String userId) async {
    final row = await (_db.select(_db.nutritionProfiles)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  /// Profili kaydeder; kullanıcının profili zaten varsa üzerine yazar.
  Future<void> saveProfile(String userId, NutritionProfile profile) {
    final i = profile.input;
    final r = profile.result;
    final entry = NutritionProfilesCompanion.insert(
      userId: userId,
      gender: i.gender.name,
      age: i.age,
      heightCm: i.heightCm,
      weightKg: i.weightKg,
      activityLevel: i.activityLevel.name,
      goal: i.goal.name,
      calories: r.calories,
      proteinG: r.proteinG,
      carbsG: r.carbsG,
      fatG: r.fatG,
      updatedAt: profile.updatedAt,
    );

    return _db.into(_db.nutritionProfiles).insert(
          entry,
          onConflict: DoUpdate(
            (_) => entry,
            target: [_db.nutritionProfiles.userId],
          ),
        );
  }

  NutritionProfile _toModel(NutritionProfileRow row) {
    return NutritionProfile(
      input: NutritionInput(
        gender: Gender.values.byName(row.gender),
        age: row.age,
        heightCm: row.heightCm,
        weightKg: row.weightKg,
        activityLevel: ActivityLevel.values.byName(row.activityLevel),
        goal: Goal.values.byName(row.goal),
      ),
      result: NutritionResult(
        calories: row.calories,
        proteinG: row.proteinG,
        carbsG: row.carbsG,
        fatG: row.fatG,
      ),
      updatedAt: row.updatedAt,
    );
  }
}
