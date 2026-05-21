import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/supplier.dart';

class SupplierRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar proveedor
  Future<int> insertar(Supplier proveedor) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'proveedor',
      proveedor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los proveedores
  Future<List<Supplier>> obtenerTodos() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'proveedor',
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => Supplier.fromMap(mapa))
        .toList();
  }

  /// Obtener proveedor por ID
  Future<Supplier?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'proveedor',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return Supplier.fromMap(mapas.first);
  }

  /// Buscar proveedores por nombre
  Future<List<Supplier>> buscarPorNombre(String texto) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'proveedor',
      where: 'nombre LIKE ?',
      whereArgs: ['%$texto%'],
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => Supplier.fromMap(mapa))
        .toList();
  }

  /// Actualizar proveedor
  Future<int> actualizar(Supplier proveedor) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'proveedor',
      proveedor.toMap(),
      where: 'id = ?',
      whereArgs: [proveedor.id],
    );
  }

  /// Eliminar proveedor
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'proveedor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar proveedores registrados
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM proveedor',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}