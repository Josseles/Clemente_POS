import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/sale.dart';
import '../models/sale_detail.dart';
import '../models/sale_detail_flavor.dart';

class SaleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Guardar una venta completa con:
  /// - venta
  /// - detalleVenta
  /// - detalleVentaSabor
  Future<void> insertar(
    Sale venta,
    List<SaleDetail> detalles,
    Map<int?, List<String>> saboresPorDetalle,
  ) async {
    final Database db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // 1. Insertar venta
      await txn.insert(
        'venta',
        venta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 2. Insertar detalles de venta
      for (final detalle in detalles) {
        final int detalleVentaId = await txn.insert(
          'detalleVenta',
          detalle.toMap(),
        );

        // 3. Insertar sabores asociados al detalle
        final List<String> sabores =
            saboresPorDetalle[detalle.id] ?? [];

        for (final saborId in sabores) {
          await txn.insert(
            'detalleVentaSabor',
            {
              'detalleVentaId': detalleVentaId,
              'saborId': saborId,
            },
          );
        }
      }
    });
  }

  /// Obtener todas las ventas
  Future<List<Sale>> obtenerTodas() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'venta',
      orderBy: 'fechaHora DESC',
    );

    return mapas
        .map((mapa) => Sale.fromMap(mapa))
        .toList();
  }

  /// Obtener venta por folio
  Future<Sale?> obtenerPorFolio(String folio) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'venta',
      where: 'folio = ?',
      whereArgs: [folio],
    );

    if (mapas.isEmpty) return null;

    return Sale.fromMap(mapas.first);
  }

  /// Obtener detalles de una venta
  Future<List<SaleDetail>> obtenerDetalles(
    String folio,
  ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'detalleVenta',
      where: 'ventaId = ?',
      whereArgs: [folio],
    );

    return mapas
        .map((mapa) => SaleDetail.fromMap(mapa))
        .toList();
  }

  /// Obtener sabores asociados a un detalle de venta
  Future<List<SaleDetailFlavor>> obtenerSaboresDetalle(
    int detalleVentaId,
  ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'detalleVentaSabor',
      where: 'detalleVentaId = ?',
      whereArgs: [detalleVentaId],
    );

    return mapas
        .map((mapa) => SaleDetailFlavor.fromMap(mapa))
        .toList();
  }

  /// Obtener total vendido en una fecha
  Future<double> obtenerTotalPorFecha(String fecha) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> resultado =
        await db.rawQuery(
      '''
      SELECT SUM(total) AS total
      FROM venta
      WHERE DATE(fechaHora) = ?
      ''',
      [fecha],
    );

    final valor = resultado.first['total'];

    if (valor == null) return 0.0;

    return (valor as num).toDouble();
  }

  /// Contar ventas registradas
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final resultado = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM venta',
    );

    return Sqflite.firstIntValue(resultado) ?? 0;
  }

    /// Total vendido en EFECTIVO
  Future<double> obtenerTotalEfectivo() async {
    final Database db = await _databaseHelper.database;

    final resultado = await db.rawQuery(
      '''
      SELECT SUM(total) AS total
      FROM venta
      WHERE metodoPago = 'efectivo'
      ''',
    );

    final valor = resultado.first['total'];

    if (valor == null) return 0.0;

    return (valor as num).toDouble();
  }

  /// Total vendido en TARJETA
  Future<double> obtenerTotalTarjeta() async {
    final Database db = await _databaseHelper.database;

    final resultado = await db.rawQuery(
      '''
      SELECT SUM(total) AS total
      FROM venta
      WHERE metodoPago = 'tarjeta'
      ''',
    );

    final valor = resultado.first['total'];

    if (valor == null) return 0.0;

    return (valor as num).toDouble();
  }

  /// Total general vendido
  Future<double> obtenerTotalGeneral() async {
    final Database db = await _databaseHelper.database;

    final resultado = await db.rawQuery(
      '''
      SELECT SUM(total) AS total
      FROM venta
      ''',
    );

    final valor = resultado.first['total'];

    if (valor == null) return 0.0;

    return (valor as num).toDouble();
  }
}