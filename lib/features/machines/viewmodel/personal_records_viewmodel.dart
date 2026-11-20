import 'package:flutter/foundation.dart';

import '../model/machine_pr.dart';
import '../repository/pr_repository.dart';

/// "Rekorlarım" ekranının durumu.
class PersonalRecordsViewModel extends ChangeNotifier {
  PersonalRecordsViewModel({
    required PrRepository repository,
    required this.userId,
  }) : _repo = repository;

  final PrRepository _repo;
  final String userId;

  List<MachinePr> records = [];
  bool isLoading = true;
  String? errorMessage;

  /// Listeyi veritabanından (yeniden) yükler. Detay ekranından dönünce de
  /// çağrılır ki yeni kayıtlar görünsün.
  Future<void> load() async {
    try {
      records = await _repo.getPersonalRecords(userId: userId);
      errorMessage = null;
    } catch (_) {
      errorMessage = 'Rekorlar yüklenemedi.';
    }
    isLoading = false;
    notifyListeners();
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
}
