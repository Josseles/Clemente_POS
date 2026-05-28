import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/cash_closing.dart';

class CashClosingRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  /// Insertar cierre de caja
  Future<int> insertar(
    CashClosing cierre,
  ) async {
    final Database db =
        await _databaseHelper.database;

    return await db.insert(
      'cierreCaja',
      cierre.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  /// Obtener cierre por apertura
  Future<CashClosing?>
  obtenerPorApertura(
    String aperturaId,
  ) async {
    final Database db =
        await _databaseHelper.database;

    final maps = await db.query(
      'cierreCaja',
      where: 'aperturaId = ?',
      whereArgs: [aperturaId],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return CashClosing.fromMap(
      maps.first,
    );
  }

  /// Verificar si una apertura ya fue cerrada
  Future<bool> estaCerrada(
    String aperturaId,
  ) async {
    final cierre =
        await obtenerPorApertura(
      aperturaId,
    );

    return cierre != null;
  }

  /// Obtener todos los cierres
  Future<List<CashClosing>>
  obtenerTodos() async {
    final Database db =
        await _databaseHelper.database;

    final maps = await db.query(
      'cierreCaja',
      orderBy:
          'fechaHoraCierre DESC',
    );

    return maps
        .map(
          (map) =>
              CashClosing.fromMap(
                map,
              ),
        )
        .toList();
  }

  /// Obtener cierre por ID
  Future<CashClosing?>
  obtenerPorId(String id) async {
    final Database db =
        await _databaseHelper.database;

    final maps = await db.query(
      'cierreCaja',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return CashClosing.fromMap(
      maps.first,
    );
  }
}