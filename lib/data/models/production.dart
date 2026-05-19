class Production {
  final int? id;
  final int flavorId;
  final String date;
  final double quantityLiters;
  final double productionCost;

  Production({
    this.id,
    required this.flavorId,
    required this.date,
    required this.quantityLiters,
    required this.productionCost,
  });

  /// Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saborId': flavorId,
      'fecha': date,
      'cantidadLitros': quantityLiters,
      'costoProduccion': productionCost,
    };
  }

  /// Crear objeto desde un Map de SQLite
  factory Production.fromMap(Map<String, dynamic> map) {
    return Production(
      id: map['id'] as int?,
      flavorId: map['saborId'] as int,
      date: map['fecha'] as String,
      quantityLiters: (map['cantidadLitros'] as num).toDouble(),
      productionCost: (map['costoProduccion'] as num).toDouble(),
    );
  }
}