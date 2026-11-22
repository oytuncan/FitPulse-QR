import 'package:cloud_firestore/cloud_firestore.dart';

/// Kullanıcının bir ödül talebi (`redemptions/{id}`).
class Redemption {
  const Redemption({
    required this.id,
    required this.rewardName,
    required this.costPoints,
    required this.createdAt,
    required this.status,
  });

  /// Yeni taleplerin başlangıç durumu.
  static const pendingStatus = 'beklemede';

  final String id;
  final String rewardName;
  final int costPoints;

  /// Sunucu saati henüz gelmediyse null olabilir.
  final DateTime? createdAt;
  final String status;

  factory Redemption.fromMap(String id, Map<String, dynamic> data) {
    final cost = data['costPoints'];
    final created = data['createdAt'];
    return Redemption(
      id: id,
      rewardName: data['rewardName'] as String? ?? '',
      costPoints: cost is num ? cost.toInt() : 0,
      createdAt: created is Timestamp ? created.toDate() : null,
      status: data['status'] as String? ?? pendingStatus,
    );
  }

  /// "beklemede" -> "Beklemede"
  String get statusLabel =>
      status.isEmpty ? '' : status[0].toUpperCase() + status.substring(1);
}
