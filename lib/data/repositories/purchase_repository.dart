import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/purchase.dart';
import '../models/purchase_detail.dart';

class PurchaseRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar una compra completa con sus detalles
  Future<int> insert(
    Purchase purchase,
    List<PurchaseDetail> details,
  ) async {
    final Database db = await _databaseHelper.database;

    return await db.transaction((txn) async {
      // Insertar compra
      final int purchaseId = await txn.insert(
        'compra',
        purchase.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insertar detalles
      for (final detail in details) {
        await txn.insert(
          'detalleCompra',
          {
            ...detail.toMap(),
            'compraId': purchaseId,
          },
        );

        // Actualizar stock del inventario
        await txn.rawUpdate(
          '''
          UPDATE articuloInventario
          SET stock = stock + ?
          WHERE id = ?
          ''',
          [
            detail.quantity,
            detail.inventoryItemId,
          ],
        );
      }

      return purchaseId;
    });
  }

  /// Obtener todas las compras
  Future<List<Purchase>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'compra',
      orderBy: 'fecha DESC',
    );

    return maps.map((map) => Purchase.fromMap(map)).toList();
  }

  /// Obtener compra por ID
  Future<Purchase?> getById(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'compra',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Purchase.fromMap(maps.first);
  }

  /// Obtener detalles de una compra
  Future<List<PurchaseDetail>> getDetails(int purchaseId) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'detalleCompra',
      where: 'compraId = ?',
      whereArgs: [purchaseId],
    );

    return maps
        .map((map) => PurchaseDetail.fromMap(map))
        .toList();
  }

  /// Eliminar compra
  Future<int> delete(int id) async {
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

  /// Contar compras
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM compra',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}