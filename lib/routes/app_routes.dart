import 'package:flutter/material.dart';

import '../presentation/screens/login_screen.dart';
import '../presentation/screens/menu/employee_menu_screen.dart';
import '../data/models/employee.dart';
import '../presentation/screens/employees/employee_register_screen.dart';
import '../presentation/screens/employees/employee_list_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const employeeMenu = '/employee-menu';
  static const employeeList = '/employee-list';
  static const employeeRegister = '/employee-register';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    employeeMenu: (context) {
      final employee = ModalRoute.of(context)!.settings.arguments as Employee;
      return EmployeeMenuScreen(employee: employee);
    },
    employeeList: (context) => const EmployeeListScreen(),
    employeeRegister: (context) => const EmployeeRegisterScreen(),
  };
}
