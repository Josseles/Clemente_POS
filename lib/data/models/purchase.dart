class Purchase {
  final int? id;
  final int proveedorId;
  final String fecha;
  final double total;

  Purchase({
    this.id,
    required this.proveedorId,
    required this.fecha,
    required this.total,
  });

  /// Convierte el objeto Purchase a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proveedorId': proveedorId,
      'fecha': fecha,
      'total': total,
    };
  }

  /// Crea un Purchase a partir de un Map<String, dynamic>
  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as int?,
      proveedorId: map['proveedorId'] as int,
      fecha: map['fecha'] as String,
      total: (map['total'] as num).toDouble(),
    );
  }
}