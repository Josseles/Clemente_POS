import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/inventory_item.dart';

class InventoryRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar artículo de inventario
  Future<int> insertar(InventoryItem articulo) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'articuloInventario',
      articulo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los artículos
  Future<List<InventoryItem>> obtenerTodos() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'articuloInventario',
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => InventoryItem.fromMap(mapa))
        .toList();
  }

  /// Buscar artículo por ID
  Future<InventoryItem?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'articuloInventario',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return InventoryItem.fromMap(mapas.first);
  }

  /// Buscar artículos por nombre
  Future<List<InventoryItem>> buscarPorNombre(String texto) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'articuloInventario',
      where: 'nombre LIKE ?',
      whereArgs: ['%$texto%'],
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => InventoryItem.fromMap(mapa))
        .toList();
  }

  /// Actualizar artículo
  Future<int> actualizar(InventoryItem articulo) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'articuloInventario',
      articulo.toMap(),
      where: 'id = ?',
      whereArgs: [articulo.id],
    );
  }

  /// Eliminar artículo
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'articuloInventario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Actualizar stock
  Future<int> actualizarStock({
    required int id,
    required int nuevoStock,
  }) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'articuloInventario',
      {'stock': nuevoStock},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Obtener artículos con stock bajo
  Future<List<InventoryItem>> obtenerStockBajo({
    int limite = 10,
  }) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'articuloInventario',
      where: 'stock <= ?',
      whereArgs: [limite],
      orderBy: 'stock ASC',
    );

    return mapas
        .map((mapa) => InventoryItem.fromMap(mapa))
        .toList();
  }

  /// Contar artículos registrados
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM articuloInventario',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}