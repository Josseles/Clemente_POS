// lib/data/repositories/employee_repository.dart

import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../models/employee.dart';

class EmployeeRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Insertar un nuevo empleado
  Future<int> insert(Employee employee) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      'employee',
      employee.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Obtener todos los empleados
  Future<List<Employee>> getAll() async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'employee',
      orderBy: 'nombre ASC',
    );

    return maps.map((map) => Employee.fromMap(map)).toList();
  }

  /// Obtener un empleado por su ID
  Future<Employee?> getById(int id) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Employee.fromMap(maps.first);
  }

  /// Iniciar sesión con nombre de usuario y PIN
  Future<Employee?> login({
    required String username,
    required String pin,
  }) async {
    final Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'employee',
      where: 'username = ? AND pin = ?',
      whereArgs: [username, pin],
    );

    if (maps.isEmpty) return null;

    return Employee.fromMap(maps.first);
  }

  /// Actualizar empleado
  Future<int> update(Employee employee) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      'employee',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  /// Eliminar empleado
  Future<int> delete(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete(
      'employee',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Contar empleados registrados
  Future<int> count() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM employee',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Verificar si existe al menos un administrador
  Future<bool> hasAdministrator() async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      'employee',
      where: 'rolEmpleado = ?',
      whereArgs: ['Administrador'],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}