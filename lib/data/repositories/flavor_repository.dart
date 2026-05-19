import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/flavor.dart';

class FlavorRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar sabor
  Future<int> insert(Flavor flavor) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'sabor',
      flavor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los sabores
  Future<List<Flavor>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'sabor',
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Flavor.fromMap(map)).toList();
  }

  /// Obtener sabores activos
  Future<List<Flavor>> getActive() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'sabor',
      where: 'activo = ?',
      whereArgs: [1],
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Flavor.fromMap(map)).toList();
  }

  /// Obtener sabor por ID
  Future<Flavor?> getById(String id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'sabor',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Flavor.fromMap(maps.first);
  }

  /// Actualizar sabor
  Future<int> update(Flavor flavor) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'sabor',
      flavor.toMap(),
      where: 'id = ?',
      whereArgs: [flavor.id],
    );
  }

  /// Eliminar sabor
  Future<int> delete(String id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'sabor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Activar o desactivar sabor
  Future<int> setActive({
    required String id,
    required bool isActive,
  }) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'sabor',
      {
        'activo': isActive ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar sabores
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM sabor',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}