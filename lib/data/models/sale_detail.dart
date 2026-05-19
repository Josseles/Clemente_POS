class SaleDetail {
  final int? id;
  final String saleId;
  final String productId;
  final int quantity;
  final double price;
  final double subtotal;

  SaleDetail({
    this.id,
    required this.saleId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.subtotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ventaId': saleId,
      'productoId': productId,
      'cantidad': quantity,
      'precio': price,
      'subtotal': subtotal,
    };
  }

  factory SaleDetail.fromMap(Map<String, dynamic> map) {
    return SaleDetail(
      id: map['id'] as int?,
      saleId: map['ventaId'] as String,
      productId: map['productoId'] as String,
      quantity: map['cantidad'] as int,
      price: (map['precio'] as num).toDouble(),
      subtotal: (map['subtotal'] as num).toDouble(),
    );
  }
}