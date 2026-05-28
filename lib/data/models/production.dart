class Production {
  final int? id;
  final int saborId;
  final String fecha;
  final double cantidadLitros;
  final double costoProduccion;

  Production({
    this.id,
    required this.saborId,
    required this.fecha,
    required this.cantidadLitros,
    required this.costoProduccion,
  });

  /// Convierte el objeto Production a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'saborId': saborId,
      'fecha': fecha,
      'cantidadLitros': cantidadLitros,
      'costoProduccion': costoProduccion,
    };
  }

  /// Crea un Production a partir de un Map<String, dynamic>
  factory Production.fromMap(Map<String, dynamic> map) {
    return Production(
      id: map['id'] as int?,
      saborId: map['saborId'] as int,
      fecha: map['fecha'] as String,
      cantidadLitros:
          (map['cantidadLitros'] as num).toDouble(),
      costoProduccion:
          (map['costoProduccion'] as num).toDouble(),
    );
  }
}