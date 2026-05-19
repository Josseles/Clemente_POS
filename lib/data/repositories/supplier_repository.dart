import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/supplier.dart';

class SupplierRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar proveedor
  Future<int> insert(Supplier supplier) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'proveedor',
      supplier.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los proveedores
  Future<List<Supplier>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'proveedor',
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Supplier.fromMap(map)).toList();
  }

  /// Obtener proveedor por ID
  Future<Supplier?> getById(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'proveedor',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Supplier.fromMap(maps.first);
  }

  /// Buscar proveedores por nombre
  Future<List<Supplier>> search(String query) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'proveedor',
      where: 'nombre LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Supplier.fromMap(map)).toList();
  }

  /// Actualizar proveedor
  Future<int> update(Supplier supplier) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'proveedor',
      supplier.toMap(),
      where: 'id = ?',
      whereArgs: [supplier.id],
    );
  }

  /// Eliminar proveedor
  Future<int> delete(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'proveedor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar proveedores
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM proveedor',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}