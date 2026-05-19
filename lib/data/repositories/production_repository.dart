// lib/data/repositories/production_repository.dart

import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/production.dart';

class ProductionRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar producción
  Future<int> insert(Production production) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'produccion',
      production.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todas las producciones
  Future<List<Production>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'produccion',
      orderBy: 'fecha DESC',
    );

    return maps.map((map) => Production.fromMap(map)).toList();
  }

  /// Obtener producción por ID
  Future<Production?> getById(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'produccion',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Production.fromMap(maps.first);
  }

  /// Obtener producciones por sabor
  Future<List<Production>> getByFlavor(int flavorId) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'produccion',
      where: 'saborId = ?',
      whereArgs: [flavorId],
      orderBy: 'fecha DESC',
    );

    return maps.map((map) => Production.fromMap(map)).toList();
  }

  /// Obtener producciones por fecha
  Future<List<Production>> getByDate(String date) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'produccion',
      where: 'fecha = ?',
      whereArgs: [date],
    );

    return maps.map((map) => Production.fromMap(map)).toList();
  }

  /// Actualizar producción
  Future<int> update(Production production) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'produccion',
      production.toMap(),
      where: 'id = ?',
      whereArgs: [production.id],
    );
  }

  /// Eliminar producción
  Future<int> delete(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'produccion',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Calcular costo total producido en un rango
  Future<double> getTotalCost({
    required String startDate,
    required String endDate,
  }) async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(costoProduccion) AS total
      FROM produccion
      WHERE fecha BETWEEN ? AND ?
      ''',
      [startDate, endDate],
    );

    final value = result.first['total'];

    if (value == null) return 0.0;

    return (value as num).toDouble();
  }

  /// Contar producciones
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM produccion',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}