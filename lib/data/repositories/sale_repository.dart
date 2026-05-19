import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/sale.dart';
import '../models/sale_detail.dart';
import '../models/sale_detail_flavor.dart';

class SaleRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Guarda una venta completa con:
  /// - venta
  /// - detalleVenta
  /// - detalleVentaSabor
  Future<void> insert(
    Sale sale,
    List<SaleDetail> details,
    Map<int, List<String>> detailFlavors,
  ) async {
    final Database db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // 1. Insertar venta
      await txn.insert(
        'venta',
        sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 2. Insertar detalles
      for (final detail in details) {
        final int detailId = await txn.insert(
          'detalleVenta',
          detail.toMap(),
        );

        // 3. Insertar sabores del detalle
        final flavors = detailFlavors[detail.id] ?? [];

        for (final flavorId in flavors) {
          await txn.insert(
            'detalleVentaSabor',
            {
              'detalleVentaId': detailId,
              'saborId': flavorId,
            },
          );
        }
      }
    });
  }

  /// Obtener todas las ventas
  Future<List<Sale>> getAll() async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'venta',
      orderBy: 'fechaHora DESC',
    );

    return maps.map((e) => Sale.fromMap(e)).toList();
  }

  /// Obtener venta por folio
  Future<Sale?> getByFolio(String folio) async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'venta',
      where: 'folio = ?',
      whereArgs: [folio],
    );

    if (maps.isEmpty) return null;

    return Sale.fromMap(maps.first);
  }

  /// Obtener detalles de una venta
  Future<List<SaleDetail>> getDetails(String folio) async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'detalleVenta',
      where: 'ventaId = ?',
      whereArgs: [folio],
    );

    return maps.map((e) => SaleDetail.fromMap(e)).toList();
  }

  /// Obtener sabores asociados a un detalle
  Future<List<SaleDetailFlavor>> getDetailFlavors(
    int detailId,
  ) async {
    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      'detalleVentaSabor',
      where: 'detalleVentaId = ?',
      whereArgs: [detailId],
    );

    return maps
        .map((e) => SaleDetailFlavor.fromMap(e))
        .toList();
  }

  /// Total vendido en una fecha
  Future<double> getTotalByDate(String date) async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(total) as total
      FROM venta
      WHERE DATE(fechaHora) = ?
      ''',
      [date],
    );

    final value = result.first['total'];

    if (value == null) return 0.0;

    return (value as num).toDouble();
  }

  /// Número de ventas
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM venta',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}