class Supplier {
  final int? id;
  final String nombre;
  final String telefono;
  final String marca;

  Supplier({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.marca,
  });

  /// Convierte el objeto Supplier a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'marca': marca,
    };
  }

  /// Crea un Supplier a partir de un Map<String, dynamic>
  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      telefono: map['telefono'] as String? ?? '',
      marca: map['marca'] as String? ?? '',
    );
  }
}