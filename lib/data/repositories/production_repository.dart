// lib/data/repositories/production_repository.dart

import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/production.dart';

class ProductionRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar producción
  Future<int> insertar(Production produccion) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'produccion',
      produccion.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todas las producciones
  Future<List<Production>> obtenerTodas() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'produccion',
      orderBy: 'fecha DESC',
    );

    return mapas
        .map((mapa) => Production.fromMap(mapa))
        .toList();
  }

  /// Obtener producción por ID
  Future<Production?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'produccion',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isEmpty) return null;

    return Production.fromMap(mapas.first);
  }

  /// Obtener producciones por sabor
  Future<List<Production>> obtenerPorSabor(int saborId) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'produccion',
      where: 'saborId = ?',
      whereArgs: [saborId],
      orderBy: 'fecha DESC',
    );

    return mapas
        .map((mapa) => Production.fromMap(mapa))
        .toList();
  }

  /// Obtener producciones por fecha
  Future<List<Production>> obtenerPorFecha(String fecha) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'produccion',
      where: 'fecha = ?',
      whereArgs: [fecha],
    );

    return mapas
        .map((mapa) => Production.fromMap(mapa))
        .toList();
  }

  /// Actualizar producción
  Future<int> actualizar(Production produccion) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'produccion',
      produccion.toMap(),
      where: 'id = ?',
      whereArgs: [produccion.id],
    );
  }

  /// Eliminar producción
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'produccion',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Calcular costo total producido en un rango de fechas
  Future<double> obtenerCostoTotal({
    required String fechaInicio,
    required String fechaFin,
  }) async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(costoProduccion) AS total
      FROM produccion
      WHERE fecha BETWEEN ? AND ?
      ''',
      [fechaInicio, fechaFin],
    );

    final valor = result.first['total'];

    if (valor == null) return 0.0;

    return (valor as num).toDouble();
  }

  /// Contar producciones registradas
  Future<int> contar() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM produccion',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }
}