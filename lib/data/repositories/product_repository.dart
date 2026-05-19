import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/product.dart';

class ProductRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar producto
  Future<int> insert(Product product) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'producto',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los productos
  Future<List<Product>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'producto',
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Product.fromMap(map)).toList();
  }

  /// Obtener solo productos disponibles
  Future<List<Product>> getAvailable() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'producto',
      where: 'disponible = ?',
      whereArgs: [1],
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Product.fromMap(map)).toList();
  }

  /// Buscar producto por ID
  Future<Product?> getById(String id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'producto',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Product.fromMap(maps.first);
  }

  /// Actualizar producto
  Future<int> update(Product product) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'producto',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  /// Eliminar producto
  Future<int> delete(String id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'producto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Activar o desactivar producto
  Future<int> setAvailability({
    required String id,
    required bool disponible,
  }) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'producto',
      {
        'disponible': disponible ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar productos
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM producto',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}