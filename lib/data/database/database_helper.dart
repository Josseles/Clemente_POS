// lib/data/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  // Obtener instancia de la BD
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar base de datos
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'clemente_pos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crear tablas
  Future<void> _onCreate(Database db, int version) async {
    // ==========================
    // TABLA EMPLEADO
    // ==========================
    await db.execute('''
      CREATE TABLE employee (
        id INTEGER PRIMARY KEY,
        nombre TEXT NOT NULL,
        telefono TEXT,
        password TEXT NOT NULL,
        rolEmpleado TEXT NOT NULL
          CHECK (rolEmpleado IN ('Administrador', 'Cajero'))
      )
    ''');

    // ==========================
    // TABLA PRODUCTO
    // ==========================
    await db.execute('''
      CREATE TABLE producto (
        id TEXT PRIMARY KEY,
        nombre TEXT NOT NULL,
        precio REAL NOT NULL,
        disponible INTEGER NOT NULL,
        iva REAL NOT NULL,
        ieps REAL NOT NULL
      )
    ''');

    // ==========================
    // TABLA SABOR
    // ==========================
    await db.execute('''
      CREATE TABLE sabor (
        id TEXT PRIMARY KEY,
        nombre TEXT NOT NULL,
        tipo TEXT NOT NULL,
        activo INTEGER NOT NULL
          CHECK (tipo IN ('Agua', 'Crema'))
          CHECK (activo IN (0, 1))
      )
    ''');

    // ==========================
    // TABLA APERTURA CAJA
    // ==========================
    await db.execute('''
      CREATE TABLE aperturaCaja (
        id TEXT PRIMARY KEY,
        empleadoId TEXT NOT NULL,
        fecha TEXT NOT NULL,
        hora TEXT NOT NULL,
        montoInicial REAL NOT NULL,
        FOREIGN KEY (empleadoId) REFERENCES usuario(id)
      )
    ''');

    // ==========================
    // TABLA CIERRE CAJA
    // ==========================
    await db.execute('''
      CREATE TABLE cierreCaja (
        id TEXT PRIMARY KEY,
        aperturaId TEXT NOT NULL,
        fecha TEXT NOT NULL,
        hora TEXT NOT NULL,
        totalEfectivo REAL NOT NULL,
        totalTarjeta REAL NOT NULL,
        totalContado REAL NOT NULL,
        totalCalculado REAL NOT NULL,
        diferencia REAL NOT NULL,
        FOREIGN KEY (aperturaId) REFERENCES aperturaCaja(id)
      )
    ''');

    // ==========================
    // TABLA VENTA
    // ==========================
    await db.execute('''
      CREATE TABLE venta (
        folio TEXT PRIMARY KEY,
        fechaHora TEXT NOT NULL,
        total REAL NOT NULL,
        recibido REAL NOT NULL,
        cambio REAL NOT NULL,
        metodoPago TEXT NOT NULL,
        empleadoId TEXT NOT NULL,
        aperturaCajaId TEXT NOT NULL,
        FOREIGN KEY (empleadoId) REFERENCES usuario(id),
        FOREIGN KEY (aperturaCajaId) REFERENCES aperturaCaja(id)
          CHECK (metodoPago IN ('Efectivo', 'Tarjeta', 'Transferencia'))
      )
    ''');

    // ==========================
    // TABLA DETALLE VENTA
    // ==========================
    await db.execute('''
      CREATE TABLE detalleVenta (
        id INTEGER PRIMARY KEY,
        ventaId TEXT NOT NULL,
        productoId TEXT NOT NULL,
        cantidad INTEGER NOT NULL,
        precio REAL NOT NULL,
        subtotal REAL NOT NULL,
        FOREIGN KEY (ventaId) REFERENCES venta(folio),
        FOREIGN KEY (productoId) REFERENCES producto(id)
      )
    ''');

    // ==========================
    // TABLA DETALLE VENTA SABOR
    // ==========================
    await db.execute('''
      CREATE TABLE detalleVentaSabor (
        id INTEGER PRIMARY KEY,
        detalleVentaId INTEGER NOT NULL,
        saborId INTEGER NOT NULL,
        FOREIGN KEY (detalleVentaId) REFERENCES detalleVenta(id),
        FOREIGN KEY (saborId) REFERENCES sabor(id)
      )
    ''');

    // ==========================
    // TABLA ARTÍCULO INVENTARIO
    // ==========================
    await db.execute('''
      CREATE TABLE articuloInventario (
        id INTEGER PRIMARY KEY,
        nombre TEXT NOT NULL,
        stock INTEGER NOT NULL,
        costo REAL NOT NULL
      )
    ''');

    // ==========================
    // TABLA PRODUCCIÓN
    // ==========================
    await db.execute('''
      CREATE TABLE produccion (
        id INTEGER PRIMARY KEY,
        saborId INTEGER NOT NULL,
        fecha TEXT NOT NULL,
        cantidadLitros REAL NOT NULL,
        costoProduccion REAL NOT NULL,
        FOREIGN KEY (saborId) REFERENCES sabor(id)
      )
    ''');

    // ==========================
    // TABLA PROVEEDOR
    // ==========================
    await db.execute('''
      CREATE TABLE proveedor (
        id INTEGER PRIMARY KEY,
        nombre TEXT NOT NULL,
        telefono TEXT,
        producto TEXT
      )
    ''');

    // ==========================
    // TABLA COMPRA
    // ==========================
    await db.execute('''
      CREATE TABLE compra (
        id INTEGER PRIMARY KEY,
        proveedorId INTEGER NOT NULL,
        fecha TEXT NOT NULL,
        total REAL NOT NULL,
        FOREIGN KEY (proveedorId) REFERENCES proveedor(id)
      )
    ''');

    // ==========================
    // TABLA DETALLE COMPRA
    // ==========================
    await db.execute('''
      CREATE TABLE detalleCompra (
        id INTEGER PRIMARY KEY,
        compraId INTEGER NOT NULL,
        articuloInventarioId INTEGER NOT NULL,
        cantidad INTEGER NOT NULL,
        costoUnitario REAL NOT NULL,
        FOREIGN KEY (compraId) REFERENCES compra(id),
        FOREIGN KEY (articuloInventarioId)
          REFERENCES articuloInventario(id)
      )
    ''');
  }

  // Cerrar BD
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}