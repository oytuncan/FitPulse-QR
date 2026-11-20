enum Gender {
  male('Erkek'),
  female('Kadın');

  const Gender(this.label);
  final String label;
}

enum ActivityLevel {
  sedentary('Hareketsiz'),
  light('Hafif aktif'),
  moderate('Orta aktif'),
  intense('Yoğun aktif');

  const ActivityLevel(this.label);
  final String label;
}

enum Goal {
  lose('Kilo ver'),
  maintain('Kilomu koru'),
  gain('Kilo al');

  const Goal(this.label);
  final String label;
}

/// Kullanıcının forma girdiği bilgiler.
class NutritionInput {
  const NutritionInput({
    required this.gender,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.activityLevel,
    required this.goal,
  });

  final Gender gender;
  final int age;
  final double heightCm;
  final double weightKg;
  final ActivityLevel activityLevel;
  final Goal goal;
}

/// Hesaplanan günlük hedefler (yuvarlanmış).
class NutritionResult {
  const NutritionResult({
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
  });

  final int calories;
  final int proteinG;
  final int carbsG;
  final int fatG;
}

/// Kaydedilen profil: girdiler + sonuç.
class NutritionProfile {
  const NutritionProfile({
    required this.input,
    required this.result,
    required this.updatedAt,
  });

  final NutritionInput input;
  final NutritionResult result;
  final DateTime updatedAt;
}
