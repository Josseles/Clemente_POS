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
    Map<int, List<int>> saboresPorDetalle,
  ) async {
    final Database db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // 1. Insertar venta
      final int generatedFolio = await txn.insert(
        'venta',
        venta.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 2. Insertar detalles de venta
      for (int i = 0; i < detalles.length; i++) {
        final detalle = detalles[i];
        
        // Crear un nuevo mapa con el ventaId correcto
        final detalleMap = detalle.toMap();
        detalleMap['ventaId'] = generatedFolio;
        if (detalleMap.containsKey('id')) detalleMap.remove('id');

        final int detalleVentaId = await txn.insert(
          'detalleVenta',
          detalleMap,
        );

        // 3. Insertar sabores asociados al detalle
        // Usamos el índice i para referenciar los sabores en el mapa
        final List<int> sabores = saboresPorDetalle[i] ?? [];

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
      orderBy: 'folio DESC',
    );

    return mapas
        .map((mapa) => Sale.fromMap(mapa))
        .toList();
  }

  /// Obtener venta por folio
  Future<Sale?> obtenerPorFolio(int folio) async {
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
    int folio,
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

  /// Obtener ventas por apertura de caja
  Future<List<Sale>> obtenerPorApertura(int aperturaId) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'venta',
      where: 'aperturaCajaId = ?',
      whereArgs: [aperturaId],
    );

    return mapas.map((mapa) => Sale.fromMap(mapa)).toList();
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
      WHERE metodoPago = 'Efectivo'
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
      WHERE metodoPago = 'Tarjeta'
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