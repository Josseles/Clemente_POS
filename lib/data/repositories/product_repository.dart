import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/product.dart';

class ProductRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar producto
  Future<int> insertar(Product producto) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'producto',
      producto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los productos
  Future<List<Product>> obtenerTodos() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'producto',
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => Product.fromMap(mapa))
        .toList();
  }

  /// Buscar producto por ID
  Future<Product?> obtenerPorId(String id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'producto',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return Product.fromMap(mapas.first);
  }

  /// Actualizar producto
  Future<int> actualizar(Product producto) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'producto',
      producto.toMap(),
      where: 'id = ?',
      whereArgs: [producto.id],
    );
  }

  /// Eliminar producto
  Future<int> eliminar(String id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'producto',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar productos registrados
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM producto',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}