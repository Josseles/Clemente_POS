// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   // Instancia única (Singleton) para usarla en toda la app
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('clemente_pos.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String fileName) async {
//     // 1. Obtener la ruta del directorio de bases de datos en el dispositivo (tablet/emulador)
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, fileName);

//     // 2. Verificar si la base de datos ya existe en el almacenamiento local
//     final exists = await databaseExists(path);

//     if (!exists) {
//       // Si no existe (es la primera vez que se abre la app), hacemos la copia
//       print("Creando una copia de la base de datos desde los assets...");

//       try {
//         // Asegurarse de que el directorio exista
//         await Directory(dirname(path)).create(recursive: true);
        
//         // Leer el archivo desde la carpeta assets
//         ByteData data = await rootBundle.load(join("assets", fileName));
//         List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        
//         // Escribir la copia en el almacenamiento de la tablet
//         await File(path).writeAsBytes(bytes, flush: true);
//         print("¡Base de datos pre-cargada con éxito!");
//       } catch (e) {
//         print("Error al copiar la base de datos: $e");
//       }
//     } else {
//       print("La base de datos ya existía en el dispositivo.");
//     }

//     // 3. Abrir la base de datos local
//     return await openDatabase(path);
//   }

//   // --- EJEMPLO DE CONSULTA ---
//   // Puedes crear funciones aquí abajo para interactuar con tus tablas
//   Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
//     final db = await instance.database;
//     // 'usuarios' debe ser el nombre exacto de la tabla que hiciste en DB Browser
//     return await db.query('usuarios'); 
//   }
// }