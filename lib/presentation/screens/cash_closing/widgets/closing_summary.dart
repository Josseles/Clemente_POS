import 'package:flutter/material.dart';

class ClosingSummary
    extends StatelessWidget {
  final double totalEfectivo;
  final double totalTarjeta;
  final double totalCalculado;

  const ClosingSummary({
    super.key,
    required this.totalEfectivo,
    required this.totalTarjeta,
    required this.totalCalculado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          'Total efectivo: \$${totalEfectivo.toStringAsFixed(2)}',

          style: const TextStyle(
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Total tarjeta: \$${totalTarjeta.toStringAsFixed(2)}',

          style: const TextStyle(
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Total calculado: \$${totalCalculado.toStringAsFixed(2)}',

          style: const TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}