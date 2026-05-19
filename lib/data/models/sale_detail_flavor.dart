class SaleDetailFlavor {
  final int? id;
  final int saleDetailId;
  final String flavorId;

  SaleDetailFlavor({
    this.id,
    required this.saleDetailId,
    required this.flavorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'detalleVentaId': saleDetailId,
      'saborId': flavorId,
    };
  }

  factory SaleDetailFlavor.fromMap(Map<String, dynamic> map) {
    return SaleDetailFlavor(
      id: map['id'] as int?,
      saleDetailId: map['detalleVentaId'] as int,
      flavorId: map['saborId'].toString(),
    );
  }
}