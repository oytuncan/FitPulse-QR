/// Şimdilik tek salon var: Firestore'daki `gyms/main` belgesi.
const String mainGymId = 'main';

/// Bir salonun anlık doluluk bilgisi (`gyms/<id>` belgesi).
class GymOccupancy {
  const GymOccupancy({
    required this.name,
    required this.capacity,
    required this.activeCount,
  });

  final String name;
  final int capacity;
  final int activeCount;

  /// Bu yüzdenin üstünde kart uyarı rengine geçer.
  static const crowdedThreshold = 80;

  /// Doluluk yüzdesi, en yakın tam sayıya yuvarlanmış.
  int get percent => capacity <= 0 ? 0 : (activeCount / capacity * 100).round();

  bool get isFull => activeCount >= capacity;

  bool get isCrowded => percent > crowdedThreshold;

  /// Belge verisini okur; alanlar eksik ya da hatalıysa null döndürür.
  static GymOccupancy? tryParse(Map<String, dynamic>? data) {
    final capacity = data?['capacity'];
    final activeCount = data?['activeCount'];
    if (capacity is! num || activeCount is! num) return null;

    return GymOccupancy(
      name: data?['name'] as String? ?? '',
      capacity: capacity.toInt(),
      activeCount: activeCount.toInt(),
    );
  }
}
