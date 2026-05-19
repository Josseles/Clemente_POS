class Supplier {
  final int? id;
  final String name;
  final String phone;
  final String product;

  Supplier({
    this.id,
    required this.name,
    required this.phone,
    required this.product,
  });

  /// Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'telefono': phone,
      'producto': product,
    };
  }

  /// Crear objeto desde un Map de SQLite
  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as int?,
      name: map['nombre'] as String,
      phone: map['telefono'] as String? ?? '',
      product: map['producto'] as String? ?? '',
    );
  }
}