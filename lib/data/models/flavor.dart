enum FlavorCategory {
  agua,
  crema,
}

class Flavor {
  final String id;
  final String name;
  final FlavorCategory category;
  final bool isActive;

  Flavor({
    required this.id,
    required this.name,
    required this.category,
    this.isActive = false,
  });

  /// Convertir objeto Flavor a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'tipo': category == FlavorCategory.agua ? 'Agua' : 'Crema',
      'activo': isActive ? 1 : 0,
    };
  }

  /// Crear Flavor a partir de un Map de SQLite
  factory Flavor.fromMap(Map<String, dynamic> map) {
    return Flavor(
      id: map['id'].toString(),
      name: map['nombre'],
      category: map['tipo'] == 'Agua'
          ? FlavorCategory.agua
          : FlavorCategory.crema,
      isActive: map['activo'] == 1,
    );
  }
}