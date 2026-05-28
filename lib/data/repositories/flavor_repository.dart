import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/flavor.dart';

class FlavorRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar sabor
  Future<int> insertar(Flavor sabor) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'sabor',
      sabor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los sabores
  Future<List<Flavor>> obtenerTodos() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'sabor',
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => Flavor.fromMap(mapa))
        .toList();
  }

  /// Obtener sabores activos
  Future<List<Flavor>> obtenerActivos() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'sabor',
      where: 'activo = ?',
      whereArgs: [1],
      orderBy: 'nombre ASC',
    );

    return mapas
        .map((mapa) => Flavor.fromMap(mapa))
        .toList();
  }

  /// Buscar sabor por ID
  Future<Flavor?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'sabor',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return Flavor.fromMap(mapas.first);
  }

  /// Actualizar sabor
  Future<int> actualizar(Flavor sabor) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'sabor',
      sabor.toMap(),
      where: 'id = ?',
      whereArgs: [sabor.id],
    );
  }

  /// Eliminar sabor
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'sabor',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Cambiar estado activo/inactivo
  Future<int> cambiarEstadoActivo({
    required int id,
    required bool activo,
  }) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'sabor',
      {
        'activo': activo ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar sabores registrados
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM sabor',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}