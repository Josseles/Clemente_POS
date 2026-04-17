import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clemente_pos/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    );
  }
}

