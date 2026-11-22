/// Mağazadaki bir ödül (`rewards/{id}`, konsoldan eklenir; uygulama okur).
class Reward {
  const Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.costPoints,
  });

  final String id;
  final String name;
  final String description;
  final int costPoints;

  /// Alanları eksik ya da hatalı belgeler için null (listede gösterilmez).
  static Reward? tryParse(String id, Map<String, dynamic>? data) {
    final name = data?['name'];
    final cost = data?['costPoints'];
    if (name is! String || cost is! num) return null;

    return Reward(
      id: id,
      name: name,
      description: data?['description'] as String? ?? '',
      costPoints: cost.toInt(),
    );
  }
}
