import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/cash_opening.dart';

class CashOpeningRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  /// Insertar apertura de caja
  Future<int> insertar(
    CashOpening apertura,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return await db.insert(
      'aperturaCaja',
      apertura.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  /// Obtener apertura activa de un empleado
  Future<CashOpening?>
  obtenerAperturaActivaPorEmpleado(
    String empleadoId,
  ) async {
    final Database db =
        await _databaseHelper.database;

    final List<Map<String, dynamic>>
    maps = await db.rawQuery(
      '''
      SELECT *
      FROM aperturaCaja
      WHERE empleadoId = ?
      AND id NOT IN (
        SELECT aperturaId
        FROM cierreCaja
      )
      LIMIT 1
      ''',
      [empleadoId],
    );

    if (maps.isEmpty) {
      return null;
    }

    return CashOpening.fromMap(
      maps.first,
    );
  }

  /// Verificar si tiene caja activa
  Future<bool> tieneCajaActiva(
    String empleadoId,
  ) async {
    final apertura =
        await obtenerAperturaActivaPorEmpleado(
      empleadoId,
    );

    return apertura != null;
  }

  /// Obtener todas las aperturas
  Future<List<CashOpening>>
  obtenerTodas() async {
    final Database db =
        await _databaseHelper.database;

    final maps = await db.query(
      'aperturaCaja',
      orderBy:
          'fechaHoraApertura DESC',
    );

    return maps
        .map(
          (map) =>
              CashOpening.fromMap(
                map,
              ),
        )
        .toList();
  }

  /// Obtener apertura por ID
  Future<CashOpening?>
  obtenerPorId(String id) async {
    final Database db =
        await _databaseHelper.database;

    final maps = await db.query(
      'aperturaCaja',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return CashOpening.fromMap(
      maps.first,
    );
  }
}