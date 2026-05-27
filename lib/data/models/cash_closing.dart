class CashClosing {
  final String id;

  final String aperturaId;

  final String fechaHoraCierre;

  final double totalEfectivo;
  final double totalTarjeta;

  final double totalContado;
  final double totalCalculado;

  final double diferencia;

  CashClosing({
    required this.id,
    required this.aperturaId,
    required this.fechaHoraCierre,
    required this.totalEfectivo,
    required this.totalTarjeta,
    required this.totalContado,
    required this.totalCalculado,
    required this.diferencia,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aperturaId': aperturaId,
      'fechaHoraCierre': fechaHoraCierre,
      'totalEfectivo': totalEfectivo,
      'totalTarjeta': totalTarjeta,
      'totalContado': totalContado,
      'totalCalculado': totalCalculado,
      'diferencia': diferencia,
    };
  }

  factory CashClosing.fromMap(
    Map<String, dynamic> map,
  ) {
    return CashClosing(
      id: map['id'].toString(),

      aperturaId:
          map['aperturaId'].toString(),

      fechaHoraCierre: map['fechaHoraCierre'] as String,

      totalEfectivo:
          (map['totalEfectivo'] as num)
              .toDouble(),

      totalTarjeta:
          (map['totalTarjeta'] as num)
              .toDouble(),

      totalContado:
          (map['totalContado'] as num)
              .toDouble(),

      totalCalculado:
          (map['totalCalculado'] as num)
              .toDouble(),

      diferencia:
          (map['diferencia'] as num)
              .toDouble(),
    );
  }
}