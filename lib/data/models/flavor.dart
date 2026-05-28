enum CategoriaSabor {
  agua,
  crema,
}

class Flavor {
  final int? id;
  final String nombre;
  final CategoriaSabor categoria;
  final double stockLitros;
  final bool activo;

  Flavor({
    this.id,
    required this.nombre,
    required this.categoria,
    required this.stockLitros,
    this.activo = false,
  });

  Flavor copyWith({
    int? id,
    String? nombre,
    CategoriaSabor? categoria,
    double? stockLitros,
    bool? activo,
  }) {
    return Flavor(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      stockLitros: stockLitros ?? this.stockLitros,
      activo: activo ?? this.activo,
    );
  }

  /// Convierte el objeto Flavor a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'tipo': categoria == CategoriaSabor.agua
          ? 'Agua'
          : 'Crema',
      'stockLitros': stockLitros,
      'activo': activo ? 1 : 0,
    };
  }

  /// Crea un Flavor a partir de un Map<String, dynamic>
  factory Flavor.fromMap(Map<String, dynamic> map) {
    return Flavor(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      categoria: map['tipo'] == 'Agua'
          ? CategoriaSabor.agua
          : CategoriaSabor.crema,
      stockLitros:
          (map['stockLitros'] as num).toDouble(),
      activo: map['activo'] == 1,
    );
  }
}