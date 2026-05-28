class SaleDetailFlavor {
  final int? id;
  final int detalleVentaId;
  final int saborId;

  SaleDetailFlavor({
    this.id,
    required this.detalleVentaId,
    required this.saborId,
  });

  /// Convierte el objeto SaleDetailFlavor a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'detalleVentaId': detalleVentaId,
      'saborId': saborId,
    };
  }

  /// Crea un SaleDetailFlavor a partir de un Map<String, dynamic>
  factory SaleDetailFlavor.fromMap(Map<String, dynamic> map) {
    return SaleDetailFlavor(
      id: map['id'] as int?,
      detalleVentaId: map['detalleVentaId'] as int,
      saborId: map['saborId'] as int,
    );
  }
}