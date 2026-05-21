import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/employee.dart';

class EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar empleado
  Future<int> insertar(Employee empleado) async {
    final Database db = await _databaseHelper.database;
    return await db.insert(
      'employee',
      empleado.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los empleados
  Future<List<Employee>> obtenerTodos() async {
    final Database db = await _databaseHelper.database;
    final List<Map<String, dynamic>> mapas =
        await db.query('employee');

    return mapas
        .map((mapa) => Employee.fromMap(mapa))
        .toList();
  }

  /// Buscar empleado por ID
  Future<Employee?> obtenerPorId(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isNotEmpty) {
      return Employee.fromMap(mapas.first);
    }

    return null;
  }

  /// Login por nombre (usuario) y PIN
  Future<Employee?> login(
    String nombre,
    String pin,
  ) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> mapas = await db.query(
      'employee',
      where: 'nombre = ? AND pin = ?',
      whereArgs: [nombre, pin],
    );

    if (mapas.isNotEmpty) {
      return Employee.fromMap(mapas.first);
    }

    return null;
  }

  /// Actualizar empleado
  Future<int> actualizar(Employee empleado) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'employee',
      empleado.toMap(),
      where: 'id = ?',
      whereArgs: [empleado.id],
    );
  }

  /// Eliminar empleado
  Future<int> eliminar(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}