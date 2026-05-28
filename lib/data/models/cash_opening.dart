class CashOpening {
  final int? id;
  final int empleadoId;
  final String fechaHoraApertura;
  final bool cerrada;

  CashOpening({
    this.id,
    required this.empleadoId,
    required this.fechaHoraApertura,
    this.cerrada = false,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'empleadoId': empleadoId,
      'fechaHoraApertura': fechaHoraApertura,
      'cerrada': cerrada ? 1 : 0,
    };
  }

  factory CashOpening.fromMap(Map<String, dynamic> map) {
    return CashOpening(
      id: map['id'] as int?,
      empleadoId: map['empleadoId'] as int,
      fechaHoraApertura: map['fechaHoraApertura'] as String,
      cerrada: map['cerrada'] == 1,
    );
  }
}