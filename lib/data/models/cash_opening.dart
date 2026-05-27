class CashOpening {
  final String id;

  final String empleadoId;

  final String fechaHoraApertura;

  final bool cerrada;

  CashOpening({
    required this.id,
    required this.empleadoId,
    required this.fechaHoraApertura,
    this.cerrada = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'empleadoId': empleadoId,
      'fechaHoraApertura': fechaHoraApertura,
      'cerrada': cerrada ? 1 : 0,
    };
  }

  factory CashOpening.fromMap(
    Map<String, dynamic> map,
  ) {
    return CashOpening(
      id: map['id'].toString(),

      empleadoId:
          map['empleadoId'].toString(),

      fechaHoraApertura: map['fechaHoraApertura'] as String,

      cerrada: map['cerrada'] == 1,
    );
  }
}