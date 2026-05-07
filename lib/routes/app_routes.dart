import 'package:flutter/material.dart';

// Screens
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/menu/employee_menu_screen.dart';
import '../presentation/screens/employees/employee_list_screen.dart';
import '../presentation/screens/employees/employee_register_screen.dart';
import '../presentation/screens/flavors/activate_flavors_screen.dart';
import '../presentation/screens/flavors/flavor_register_screen.dart';
import '../presentation/screens/sales/sales_products_screen.dart';
import '../presentation/screens/sales/sales_type_screen.dart';
import '../presentation/screens/sales/sales_flavors_screen.dart';
import '../presentation/screens/productions/production_list_screen.dart';
import '../presentation/screens/productions/production_register_screen.dart';
import '../presentation/screens/reports/report_filter_screen.dart';

// Models
import '../data/models/employee.dart';

class AppRoutes {
  // 🔹 Rutas
  static const login = '/login';
  static const employeeMenu = '/employee-menu';
  static const employeeList = '/employee-list';
  static const employeeRegister = '/employee-register';
  static const activateFlavors = '/activate-flavors';
  static const flavorRegister = '/flavor-register';
  static const salesProducts = '/sales-products';
  static const salesType = '/sales-type';
  static const salesFlavors = '/sales-flavors';
  static const productionList = '/production-list';
  static const productionRegister = '/production-register';
  static const reportFilter = '/report-filter';

  // 🔹 Map básico (sin argumentos)
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    employeeList: (context) => const EmployeeListScreen(),
    employeeRegister: (context) => const EmployeeRegisterScreen(),
    flavorRegister: (context) => const FlavorRegisterScreen(),
    productionList: (context) => const ProductionListScreen(),
    productionRegister: (context) => const ProductionRegisterScreen(),
    reportFilter: (context) => const ReportFilterScreen(),
  };

  //Manejo de rutas con argumentos
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case employeeMenu:
        final employee = settings.arguments as Employee;
        return MaterialPageRoute(
          builder: (_) => EmployeeMenuScreen(employee: employee),
        );

      case activateFlavors:
        final employee = settings.arguments as Employee;
        return MaterialPageRoute(
          builder: (_) => ActivateFlavorsScreen(employee: employee),
        );

      case salesType:
        final product = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SalesTypeScreen(product: product),
        );

      case AppRoutes.salesProducts:
        final employee = settings.arguments as Employee;

        return MaterialPageRoute(
          builder: (_) => SalesProductsScreen(employee: employee),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
