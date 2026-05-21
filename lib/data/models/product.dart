class Product {
  final String id;
  final String nombre;
  final double precio;
  final bool iva;
  final bool ieps;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.iva,
    required this.ieps,
  });

  /// Convierte el objeto Product a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'iva': iva ? 1 : 0,
      'ieps': ieps ? 1 : 0,
    };
  }

  /// Crea un Product a partir de un Map<String, dynamic>
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      nombre: map['nombre'] as String,
      precio: (map['precio'] as num).toDouble(),
      iva: map['iva'] == 1,
      ieps: map['ieps'] == 1,
    );
  }
}