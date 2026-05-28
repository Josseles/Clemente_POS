class SaleDetail {
  final int? id;
  final int ventaId;
  final int productoId;
  final int cantidad;
  final double precio;
  final double subtotal;

  SaleDetail({
    this.id,
    required this.ventaId,
    required this.productoId,
    required this.cantidad,
    required this.precio,
    required this.subtotal,
  });

  /// Convierte el objeto SaleDetail a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'ventaId': ventaId,
      'productoId': productoId,
      'cantidad': cantidad,
      'precio': precio,
      'subtotal': subtotal,
    };
  }

  /// Crea un SaleDetail a partir de un Map<String, dynamic>
  factory SaleDetail.fromMap(Map<String, dynamic> map) {
    return SaleDetail(
      id: map['id'] as int?,
      ventaId: map['ventaId'] as int,
      productoId: map['productoId'] as int,
      cantidad: map['cantidad'] as int,
      precio: (map['precio'] as num).toDouble(),
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }
}