import 'package:flutter/foundation.dart';

import '../model/nutrition_calculator.dart';
import '../model/nutrition_profile.dart';
import '../repository/nutrition_repository.dart';

/// Doğrulama sonucu: ya değer ya da Türkçe hata.
typedef ParsedNumber = ({double? value, String? error});

/// Beslenme sekmesi ve Ana Sayfa'daki hedef kartının ortak durumu.
class NutritionViewModel extends ChangeNotifier {
  NutritionViewModel({
    required NutritionRepository repository,
    required this.userId,
  }) : _repo = repository;

  final NutritionRepository _repo;
  final String userId;

  NutritionProfile? profile;
  bool isLoading = true;
  bool isEditing = false;
  bool isSaving = false;
  String? saveError;

  // Formdaki seçimler
  Gender? gender;
  ActivityLevel? activityLevel;
  Goal? goal;

  // Alan hataları (null = hata yok)
  String? genderError;
  String? ageError;
  String? heightError;
  String? weightError;
  String? activityError;
  String? goalError;

  /// Profil yoksa ya da kullanıcı düzenliyorsa form gösterilir.
  bool get showForm => profile == null || isEditing;

  Future<void> load() async {
    try {
      profile = await _repo.getProfile(userId);
    } catch (_) {
      // Okunamazsa form gösterilir; kullanıcı yeniden kaydedebilir.
    }
    isLoading = false;
    notifyListeners();
  }

  /// Formu kayıtlı bilgilerle açar.
  void startEditing() {
    final input = profile?.input;
    gender = input?.gender;
    activityLevel = input?.activityLevel;
    goal = input?.goal;
    _clearErrors();
    isEditing = true;
    notifyListeners();
  }

  void cancelEditing() {
    _clearErrors();
    isEditing = false;
    notifyListeners();
  }

  void setGender(Gender? value) {
    gender = value;
    genderError = null;
    notifyListeners();
  }

  void setActivityLevel(ActivityLevel? value) {
    activityLevel = value;
    activityError = null;
    notifyListeners();
  }

  void setGoal(Goal? value) {
    goal = value;
    goalError = null;
    notifyListeners();
  }

  /// Girdileri doğrular, hesaplar ve kaydeder. Başarılıysa true döner.
  Future<bool> calculateAndSave({
    required String age,
    required String height,
    required String weight,
  }) async {
    final ageResult = validateAge(age);
    final heightResult = validateHeight(height);
    final weightResult = validateWeight(weight);

    ageError = ageResult.error;
    heightError = heightResult.error;
    weightError = weightResult.error;
    genderError = gender == null ? 'Cinsiyet seç.' : null;
    activityError = activityLevel == null ? 'Aktivite seviyesi seç.' : null;
    goalError = goal == null ? 'Hedef seç.' : null;
    saveError = null;

    final hasError = [
      ageError,
      heightError,
      weightError,
      genderError,
      activityError,
      goalError,
    ].any((e) => e != null);
    if (hasError) {
      notifyListeners();
      return false;
    }

    final input = NutritionInput(
      gender: gender!,
      age: ageResult.value!.toInt(),
      heightCm: heightResult.value!,
      weightKg: weightResult.value!,
      activityLevel: activityLevel!,
      goal: goal!,
    );
    final newProfile = NutritionProfile(
      input: input,
      result: NutritionCalculator.calculate(input),
      updatedAt: DateTime.now(),
    );

    isSaving = true;
    notifyListeners();
    try {
      await _repo.saveProfile(userId, newProfile);
      profile = newProfile;
      isEditing = false;
      return true;
    } catch (_) {
      saveError = 'Kaydedilemedi, lütfen tekrar dene.';
      return false;
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  void _clearErrors() {
    genderError = ageError = heightError = weightError = null;
    activityError = goalError = saveError = null;
  }

  // ---- Doğrulama (UI'dan bağımsız, statik) ----

  static final _decimalPattern = RegExp(r'^\d+([.,]\d+)?$');

  static ParsedNumber validateAge(String input) {
    final text = input.trim();
    if (text.isEmpty) return (value: null, error: 'Yaşını gir.');
    if (!RegExp(r'^\d+$').hasMatch(text)) {
      return (value: null, error: 'Yaş tam sayı olmalı.');
    }
    final value = double.parse(text);
    if (value < 14 || value > 100) {
      return (value: null, error: 'Yaş 14 ile 100 arasında olmalı.');
    }
    return (value: value, error: null);
  }

  static ParsedNumber validateHeight(String input) => _validateDecimal(
        input,
        emptyError: 'Boyunu gir.',
        min: 120,
        max: 230,
        rangeError: 'Boy 120 ile 230 cm arasında olmalı.',
      );

  static ParsedNumber validateWeight(String input) => _validateDecimal(
        input,
        emptyError: 'Kilonu gir.',
        min: 30,
        max: 300,
        rangeError: 'Kilo 30 ile 300 kg arasında olmalı.',
      );

  /// Virgül veya nokta ile ondalık kabul eder (örn. 72,5).
  static ParsedNumber _validateDecimal(
    String input, {
    required String emptyError,
    required double min,
    required double max,
    required String rangeError,
  }) {
    final text = input.trim();
    if (text.isEmpty) return (value: null, error: emptyError);
    if (!_decimalPattern.hasMatch(text)) {
      return (value: null, error: 'Geçerli bir sayı gir (örn. 72,5).');
    }
    final value = double.parse(text.replaceAll(',', '.'));
    if (value < min || value > max) return (value: null, error: rangeError);
    return (value: value, error: null);
  }

  // Oturum kapanıp ekran kaldırılırsa geç gelen cevaplar hata vermesin.
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
