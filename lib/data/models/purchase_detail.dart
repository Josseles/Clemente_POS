class PurchaseDetail {
  final int? id;
  final int compraId;
  final int articuloInventarioId;
  final int cantidad;
  final double costoUnitario;

  PurchaseDetail({
    this.id,
    required this.compraId,
    required this.articuloInventarioId,
    required this.cantidad,
    required this.costoUnitario,
  });

  /// Subtotal calculado automáticamente
  double get subtotal => cantidad * costoUnitario;

  /// Convierte el objeto PurchaseDetail a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'compraId': compraId,
      'articuloInventarioId': articuloInventarioId,
      'cantidad': cantidad,
      'costoUnitario': costoUnitario,
    };
  }

  /// Crea un PurchaseDetail a partir de un Map<String, dynamic>
  factory PurchaseDetail.fromMap(Map<String, dynamic> map) {
    return PurchaseDetail(
      id: map['id'] as int?,
      compraId: map['compraId'] as int,
      articuloInventarioId:
          map['articuloInventarioId'] as int,
      cantidad: map['cantidad'] as int,
      costoUnitario:
          (map['costoUnitario'] as num).toDouble(),
    );
  }
}