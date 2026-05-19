class Sale {
  final String folio;
  final String dateTime;
  final double total;
  final double amountReceived;
  final double change;
  final String paymentMethod;
  final int employeeId;
  final String openingId;

  Sale({
    required this.folio,
    required this.dateTime,
    required this.total,
    required this.amountReceived,
    required this.change,
    required this.paymentMethod,
    required this.employeeId,
    required this.openingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'folio': folio,
      'fechaHora': dateTime,
      'total': total,
      'recibido': amountReceived,
      'cambio': change,
      'metodoPago': paymentMethod,
      'empleadoId': employeeId,
      'aperturaCajaId': openingId,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      folio: map['folio'] as String,
      dateTime: map['fechaHora'] as String,
      total: (map['total'] as num).toDouble(),
      amountReceived: (map['recibido'] as num).toDouble(),
      change: (map['cambio'] as num).toDouble(),
      paymentMethod: map['metodoPago'] as String,
      employeeId: map['empleadoId'] as int,
      openingId: map['aperturaCajaId'] as String,
    );
  }
}