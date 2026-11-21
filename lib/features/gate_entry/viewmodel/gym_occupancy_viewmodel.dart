import 'dart:async';

import 'package:flutter/foundation.dart';

import '../model/gym_occupancy.dart';
import '../repository/gate_repository.dart';
import 'firestore_error_message.dart';

/// Ana Sayfa'daki "Salon Doluluğu" kartının canlı durumu.
class GymOccupancyViewModel extends ChangeNotifier {
  GymOccupancyViewModel({
    required GateRepository repository,
    this.gymId = mainGymId,
  }) {
    _subscription = repository
        .watchGym(gymId)
        .listen(
          (data) {
            occupancy = data;
            errorMessage = null;
            notifyListeners();
          },
          // Hata akışı kapatmaz; bağlantı gelince yeni veriyle düzelir.
          onError: (Object e) {
            errorMessage = firestoreErrorMessage(e);
            notifyListeners();
          },
        );
  }

  final String gymId;
  late final StreamSubscription<GymOccupancy> _subscription;

  GymOccupancy? occupancy;
  String? errorMessage;

  bool get isLoading => occupancy == null && errorMessage == null;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
