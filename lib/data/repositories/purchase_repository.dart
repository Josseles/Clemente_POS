import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/purchase.dart';
import '../models/purchase_detail.dart';

class PurchaseRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar una compra completa con sus detalles
  Future<int> insertar(
    Purchase compra,
    List<PurchaseDetail> detalles,
  ) async {
    final Database db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      // Insertar compra
      final int compraId = await txn.insert(
        'compra',
        compra.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insertar detalles y actualizar inventario
      for (final detalle in detalles) {
        await txn.insert(
          'detalleCompra',
          {
            ...detalle.toMap(),
            'compraId': compraId,
          },
        );

        // Actualizar stock del artículo en inventario
        await txn.rawUpdate(
          '''
          UPDATE articuloInventario
          SET stock = stock + ?
          WHERE id = ?
          ''',
          [
            detalle.cantidad,
            detalle.articuloInventarioId,
          ],
        );
      }

      return compraId;
    });
  }

  /// Obtener todas las compras
  Future<List<Purchase>> obtenerTodas() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'compra',
      orderBy: 'fecha DESC',
    );

    return mapas
        .map((mapa) => Purchase.fromMap(mapa))
        .toList();
  }

  /// Obtener compra por ID
  Future<Purchase?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'compra',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return Purchase.fromMap(mapas.first);
  }

  /// Obtener detalles de una compra
  Future<List<PurchaseDetail>> obtenerDetalles(int compraId) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'detalleCompra',
      where: 'compraId = ?',
      whereArgs: [compraId],
    );

    return mapas
        .map((mapa) => PurchaseDetail.fromMap(mapa))
        .toList();
  }

  /// Eliminar compra y sus detalles
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      await txn.delete(
        'detalleCompra',
        where: 'compraId = ?',
        whereArgs: [id],
      );

      return await txn.delete(
        'compra',
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  /// Contar compras registradas
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM compra',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}