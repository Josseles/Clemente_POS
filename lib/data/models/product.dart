class Product {
  final String id;
  final String nombre;
  final double precio;
  final bool disponible;
  final double iva;
  final double ieps;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.disponible,
    required this.iva,
    required this.ieps,
  });

  /// Convertir Product a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'disponible': disponible ? 1 : 0,
      'iva': iva,
      'ieps': ieps,
    };
  }

  /// Convertir Map de SQLite a Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      precio: (map['precio'] as num).toDouble(),
      disponible: map['disponible'] == 1,
      iva: (map['iva'] as num).toDouble(),
      ieps: (map['ieps'] as num).toDouble(),
    );
  }
}