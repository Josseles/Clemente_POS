import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/inventory_item.dart';

class InventoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar artículo de inventario
  Future<int> insert(InventoryItem item) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'articuloInventario',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los artículos
  Future<List<InventoryItem>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articuloInventario',
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => InventoryItem.fromMap(map)).toList();
  }

  /// Obtener artículo por ID
  Future<InventoryItem?> getById(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articuloInventario',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return InventoryItem.fromMap(maps.first);
  }

  /// Buscar artículos por nombre
  Future<List<InventoryItem>> search(String query) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articuloInventario',
      where: 'nombre LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => InventoryItem.fromMap(map)).toList();
  }

  /// Actualizar artículo
  Future<int> update(InventoryItem item) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'articuloInventario',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  /// Eliminar artículo
  Future<int> delete(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'articuloInventario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Ajustar stock (puede sumar o restar)
  Future<int> updateStock({
    required int id,
    required int newStock,
  }) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'articuloInventario',
      {'stock': newStock},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Obtener artículos con stock bajo
  Future<List<InventoryItem>> getLowStock({int threshold = 10}) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'articuloInventario',
      where: 'stock <= ?',
      whereArgs: [threshold],
      orderBy: 'stock ASC',
    );

    return maps.map((map) => InventoryItem.fromMap(map)).toList();
  }

  /// Contar artículos
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM articuloInventario',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}