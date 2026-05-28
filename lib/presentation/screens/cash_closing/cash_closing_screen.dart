import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../routes/app_routes.dart';

import '../../../data/models/cash_opening.dart';
import '../../../data/models/cash_closing.dart';

import '../../../data/repositories/sale_repository.dart';
import '../../../data/repositories/cash_closing_repository.dart';
import '../../../data/repositories/cash_opening_repository.dart';

import 'widgets/closing_summary.dart';
import 'widgets/counted_cash_input.dart';
import 'widgets/close_cash_button.dart';

class CashClosingScreen extends StatefulWidget {
  final CashOpening apertura;

  const CashClosingScreen({
    super.key,
    required this.apertura,
  });

  @override
  State<CashClosingScreen> createState() =>
      _CashClosingScreenState();
}

class _CashClosingScreenState
    extends State<CashClosingScreen> {

  final TextEditingController
  _efectivoController =
      TextEditingController();

  final SaleRepository
  _saleRepository =
      SaleRepository();

  final CashClosingRepository
  _cashClosingRepository =
      CashClosingRepository();

  final CashOpeningRepository
  _cashOpeningRepository =
      CashOpeningRepository();

  double totalEfectivo = 0;
  double totalTarjeta = 0;
  double totalCalculado = 0;
  double totalContado = 0;
  double diferencia = 0;
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {

    try {

      final ventas =
          await _saleRepository.obtenerTodas();

      double efectivo = 0;
      double tarjeta = 0;

      for (final venta in ventas) {

        if (venta.metodoPago ==
            'Efectivo') {

          efectivo += venta.total;

        } else {

          tarjeta += venta.total;
        }
      }

      setState(() {

        totalEfectivo = efectivo;

        totalTarjeta = tarjeta;

        totalCalculado =
            efectivo + tarjeta;

        cargando = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        cargando = false;
      });
    }
  }

  Future<void> cerrarCaja() async {

    final efectivoContado =
        double.tryParse(
              _efectivoController.text,
            ) ??
            0;

    final diferencia =
        efectivoContado -
        totalCalculado;

    // impedir cierre incorrecto
    if (diferencia != 0) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'El corte no coincide',
          ),
        ),
      );

      return;
    }

    try {

      final cierre = CashClosing(
        id: const Uuid().v4(),

        aperturaId:
            widget.apertura.id,

        fechaHoraCierre:
            DateTime.now()
                .toIso8601String(),

        totalEfectivo:
            totalEfectivo,

        totalTarjeta:
            totalTarjeta,

        totalCalculado:
            totalCalculado,

        totalContado:
            efectivoContado,

        diferencia:
            diferencia,
      );

      await _cashClosingRepository
          .insertar(cierre);

      await _cashOpeningRepository
          .cerrarCaja(
        widget.apertura.id,
      );

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if (cargando) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cierre de Caja',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(
          24,
        ),

        child: Column(
          children: [

            ClosingSummary(
              totalEfectivo:
                  totalEfectivo,

              totalTarjeta:
                  totalTarjeta,

              totalCalculado:
                  totalCalculado,
            ),

            const SizedBox(height: 30),

            CountedCashInput(
              controller:
                  _efectivoController,
            ),

            const Spacer(),

            CloseCashButton(
              onPressed: cerrarCaja,
            ),
          ],
        ),
      ),
    );
  }
}