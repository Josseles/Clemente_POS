import 'package:clemente_pos/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/app_routes.dart';

import 'data/database/database_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.instance.database;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Clemente POS',

      initialRoute: AppRoutes.login,

      routes: AppRoutes.routes,

      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}