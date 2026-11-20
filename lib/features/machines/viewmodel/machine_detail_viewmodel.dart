import 'package:flutter/foundation.dart';

import '../model/machine.dart';
import '../model/pr_entry.dart';
import '../repository/pr_repository.dart';

/// Makine detay ekranının durumu: rekor, geçmiş ve kilo girişi.
class MachineDetailViewModel extends ChangeNotifier {
  MachineDetailViewModel({
    required PrRepository repository,
    required this.userId,
    required this.machine,
  }) : _repo = repository;

  final PrRepository _repo;
  final String userId;
  final Machine machine;

  List<PrEntry> history = [];
  double? bestWeight;
  bool isLoading = true;
  bool isSaving = false;

  /// Kilo alanının altında gösterilen hata.
  String? inputError;

  Future<void> load() async {
    await _refresh();
    isLoading = false;
    notifyListeners();
  }

  /// Girdiyi doğrular ve kaydeder. Kullanıcıya gösterilecek mesajı döndürür;
  /// girdi geçersizse null döner (hata [inputError] içindedir).
  Future<String?> save(String input) async {
    final result = parseWeight(input);
    inputError = result.error;
    if (result.value == null) {
      notifyListeners();
      return null;
    }

    final weight = result.value!;
    final previousBest = bestWeight;

    isSaving = true;
    notifyListeners();
    try {
      await _repo.addRecord(
        userId: userId,
        machineId: machine.id,
        weightKg: weight,
      );
      await _refresh();
    } catch (_) {
      return 'Kayıt sırasında bir hata oluştu.';
    } finally {
      isSaving = false;
      notifyListeners();
    }

    // Sadece mevcut rekorun üstündeyse "Yeni rekor!"
    final isNewRecord = previousBest != null && weight > previousBest;
    return isNewRecord ? 'Yeni rekor!' : 'Kaydedildi.';
  }

  // Ekran, veritabanı cevabı gelmeden kapanırsa hata vermemek için.
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

  Future<void> _refresh() async {
    history = await _repo.getHistory(userId: userId, machineId: machine.id);
    bestWeight =
        await _repo.getBestWeight(userId: userId, machineId: machine.id);
  }

  // Virgül veya nokta ile ondalık: 80, 82,5, 82.5. Eksi işareti de kabul
  // edilir ki negatif değere özel hata gösterebilelim.
  static final _numberPattern = RegExp(r'^-?\d+([.,]\d+)?$');

  /// Kilo girdisini doğrular; ya değer ya da Türkçe hata döner.
  static ({double? value, String? error}) parseWeight(String input) {
    final text = input.trim();
    if (text.isEmpty) {
      return (value: null, error: 'Lütfen bir kilo değeri gir.');
    }
    if (!_numberPattern.hasMatch(text)) {
      return (value: null, error: 'Geçerli bir sayı gir (örn. 82,5).');
    }

    final value = double.parse(text.replaceAll(',', '.'));
    if (value <= 0) {
      return (value: null, error: 'Kilo sıfırdan büyük olmalı.');
    }
    return (value: value, error: null);
  }
}
