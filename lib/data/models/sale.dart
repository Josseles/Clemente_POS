class Sale {
  final int? folio;
  final String fechaHora;
  final double subtotal;
  final double totalIVA;
  final double totalIEPS;
  final double total;
  final double recibido;
  final double cambio;
  final String metodoPago;
  final int empleadoId;
  final int aperturaCajaId;

  Sale({
    this.folio,
    required this.fechaHora,
    required this.subtotal,
    required this.totalIVA,
    required this.totalIEPS,
    required this.total,
    required this.recibido,
    required this.cambio,
    required this.metodoPago,
    required this.empleadoId,
    required this.aperturaCajaId,
  });

  /// Convierte el objeto Sale a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (folio != null) 'folio': folio,
      'fechaHora': fechaHora,
      'subtotal': subtotal,
      'totalIVA': totalIVA,
      'totalIEPS': totalIEPS,
      'total': total,
      'recibido': recibido,
      'cambio': cambio,
      'metodoPago': metodoPago,
      'empleadoId': empleadoId,
      'aperturaCajaId': aperturaCajaId,
    };
  }

  /// Crea un Sale a partir de un Map<String, dynamic>
  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      folio: map['folio'] as int?,
      fechaHora: map['fechaHora'] as String,
      subtotal: (map['subtotal'] as num? ?? 0.0).toDouble(),
      totalIVA: (map['totalIVA'] as num? ?? 0.0).toDouble(),
      totalIEPS: (map['totalIEPS'] as num? ?? 0.0).toDouble(),
      total: (map['total'] as num).toDouble(),
      recibido: (map['recibido'] as num).toDouble(),
      cambio: (map['cambio'] as num).toDouble(),
      metodoPago: map['metodoPago'] as String,
      empleadoId: map['empleadoId'] as int,
      aperturaCajaId: map['aperturaCajaId'] as int,
    );
  }
}