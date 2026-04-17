import 'package:flutter/material.dart';

import '../presentation/screens/login_screen.dart';

import '../presentation/screens/menu/employee_menu_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const employeeMenu = '/employee-menu';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    employeeMenu: (context) => const EmployeeMenuScreen(),
  };
}