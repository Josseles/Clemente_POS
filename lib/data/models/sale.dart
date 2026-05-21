class Sale {
  final String folio;
  final String fechaHora;
  final double total;
  final double recibido;
  final double cambio;
  final String metodoPago;
  final int empleadoId;
  final String aperturaCajaId;

  Sale({
    required this.folio,
    required this.fechaHora,
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
      'folio': folio,
      'fechaHora': fechaHora,
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
      folio: map['folio'].toString(),
      fechaHora: map['fechaHora'] as String,
      total: (map['total'] as num).toDouble(),
      recibido: (map['recibido'] as num).toDouble(),
      cambio: (map['cambio'] as num).toDouble(),
      metodoPago: map['metodoPago'] as String,
      empleadoId: map['empleadoId'] as int,
      aperturaCajaId:
          map['aperturaCajaId'].toString(),
    );
  }
}