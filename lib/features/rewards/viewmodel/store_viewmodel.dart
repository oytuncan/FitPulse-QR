import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/utils/firestore_error_message.dart';
import '../model/redeem_result.dart';
import '../model/redemption.dart';
import '../model/reward.dart';
import '../repository/rewards_repository.dart';

/// Talep sonrası kullanıcıya gösterilecek mesaj.
typedef StoreMessage = ({String text, bool isError});

/// Mağaza sekmesi: ödül listesi, talepler ve talep etme.
class StoreViewModel extends ChangeNotifier {
  StoreViewModel({required RewardsRepository repository, required this.userId})
    : _repo = repository {
    _rewardsSub = _repo.watchRewards().listen(
      (list) {
        rewards = list;
        rewardsError = null;
        notifyListeners();
      },
      onError: (Object e) {
        rewardsError = firestoreErrorMessage(e);
        notifyListeners();
      },
    );
    _redemptionsSub = _repo
        .watchRedemptions(userId)
        .listen(
          (list) {
            redemptions = list;
            redemptionsError = null;
            notifyListeners();
          },
          onError: (Object e) {
            redemptionsError = firestoreErrorMessage(e);
            notifyListeners();
          },
        );
  }

  final RewardsRepository _repo;
  final String userId;
  late final StreamSubscription<List<Reward>> _rewardsSub;
  late final StreamSubscription<List<Redemption>> _redemptionsSub;

  /// null = henüz yüklenmedi.
  List<Reward>? rewards;
  String? rewardsError;
  List<Redemption>? redemptions;
  String? redemptionsError;

  /// Talebi işlenen ödülün id'si; işlem sürerken diğer butonlar pasif.
  String? redeemingId;

  bool get isRedeeming => redeemingId != null;

  Future<StoreMessage> redeem(Reward reward) async {
    redeemingId = reward.id;
    notifyListeners();
    try {
      final result = await _repo.redeem(userId: userId, rewardId: reward.id);
      switch (result) {
        case RedeemResult.success:
          return (text: 'Talebin alındı.', isError: false);
        case RedeemResult.insufficientPoints:
          return (text: 'Puanın bu ödül için yetersiz.', isError: true);
        case RedeemResult.rewardNotFound:
          return (text: 'Bu ödül artık mağazada yok.', isError: true);
      }
    } catch (e) {
      return (
        text: firestoreErrorMessage(e, notFound: 'Bu ödül artık mağazada yok.'),
        isError: true,
      );
    } finally {
      redeemingId = null;
      notifyListeners();
    }
  }

  // Sekme kapandıktan sonra biten istek hata vermesin.
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _rewardsSub.cancel();
    _redemptionsSub.cancel();
    super.dispose();
  }
}
