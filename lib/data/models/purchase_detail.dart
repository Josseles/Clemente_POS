// lib/data/models/purchase_detail.dart

class PurchaseDetail {
  final int? id;
  final int purchaseId;
  final int inventoryItemId;
  final int quantity;
  final double unitCost;

  PurchaseDetail({
    this.id,
    required this.purchaseId,
    required this.inventoryItemId,
    required this.quantity,
    required this.unitCost,
  });

  /// Subtotal calculado automáticamente
  double get subtotal => quantity * unitCost;

  /// Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'compraId': purchaseId,
      'articuloInventarioId': inventoryItemId,
      'cantidad': quantity,
      'costoUnitario': unitCost,
    };
  }

  /// Crear objeto desde un Map de SQLite
  factory PurchaseDetail.fromMap(Map<String, dynamic> map) {
    return PurchaseDetail(
      id: map['id'] as int?,
      purchaseId: map['compraId'] as int,
      inventoryItemId: map['articuloInventarioId'] as int,
      quantity: map['cantidad'] as int,
      unitCost: (map['costoUnitario'] as num).toDouble(),
    );
  }
}