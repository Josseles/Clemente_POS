class Purchase {
  final int? id;
  final int supplierId;
  final String date;
  final double total;

  Purchase({
    this.id,
    required this.supplierId,
    required this.date,
    required this.total,
  });

  /// Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proveedorId': supplierId,
      'fecha': date,
      'total': total,
    };
  }

  /// Crear objeto desde un Map de SQLite
  factory Purchase.fromMap(Map<String, dynamic> map) {
    return Purchase(
      id: map['id'] as int?,
      supplierId: map['proveedorId'] as int,
      date: map['fecha'] as String,
      total: (map['total'] as num).toDouble(),
    );
  }
}