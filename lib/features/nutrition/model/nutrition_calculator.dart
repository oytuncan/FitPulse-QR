import 'dart:math' as math;

import 'nutrition_profile.dart';

/// Kalori ve makro hesabı. Saf Dart; UI'a ve veritabanına bağlı değil.
class NutritionCalculator {
  NutritionCalculator._();

  /// Mifflin-St Jeor bazal metabolizma hızı (kcal).
  static double bmr(NutritionInput i) {
    final base = 10 * i.weightKg + 6.25 * i.heightCm - 5 * i.age;
    return i.gender == Gender.male ? base + 5 : base - 161;
  }

  static double activityMultiplier(ActivityLevel level) => switch (level) {
        ActivityLevel.sedentary => 1.2,
        ActivityLevel.light => 1.375,
        ActivityLevel.moderate => 1.55,
        ActivityLevel.intense => 1.725,
      };

  static double goalFactor(Goal goal) => switch (goal) {
        Goal.lose => 0.85,
        Goal.maintain => 1.0,
        Goal.gain => 1.10,
      };

  /// Güvenlik alt sınırı: günlük kalori bunun altına inmez.
  static int minCalories(Gender gender) =>
      gender == Gender.female ? 1200 : 1500;

  /// Günlük toplam enerji harcaması (kcal).
  static double tdee(NutritionInput i) =>
      bmr(i) * activityMultiplier(i.activityLevel);

  static NutritionResult calculate(NutritionInput i) {
    final target = tdee(i) * goalFactor(i.goal);
    final calories =
        math.max(target, minCalories(i.gender).toDouble()).round();

    final protein = 1.8 * i.weightKg; // gram
    final fat = calories * 0.25 / 9; // kalorinin %25'i, gram

    // Kalan kalori karbonhidrata gider. Kilo çok yüksek, kalori düşükse
    // protein kaloriyi aşabilir; karbonhidrat eksiye düşmesin.
    final remaining = calories - protein * 4 - fat * 9;
    final carbs = math.max(0.0, remaining) / 4;

    return NutritionResult(
      calories: calories,
      proteinG: protein.round(),
      carbsG: carbs.round(),
      fatG: fat.round(),
    );
  }
}
