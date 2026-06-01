import 'package:flutter/material.dart';

// Screens
//LOGIN
import '../presentation/screens/login/login_screen.dart';

//MENU
import '../presentation/screens/menu/menu_screen.dart';

//USUARIOS
import '../presentation/screens/employees/employee_list_screen.dart';
import '../presentation/screens/employees/employee_register_screen.dart';

//FLAVORS
import '../presentation/screens/flavors/activate_flavors_screen.dart';
import '../presentation/screens/flavors/flavor_register_screen.dart';

//PRODUCTOS
import '../presentation/screens/products/product_register_screen.dart';
import '../presentation/screens/products/product_edit_screen.dart';

//VENTAS
import '../presentation/screens/sales/sales_products_screen.dart';
import '../presentation/screens/sales/sales_type_screen.dart';
import '../presentation/screens/sales/sales_flavors_screen.dart';

//PRODUCTIONS
import '../presentation/screens/productions/production_list_screen.dart';
import '../presentation/screens/productions/production_register_screen.dart';

//REPORTES
import '../presentation/screens/reports/report_filter_screen.dart';

//COMPRAS
import '../presentation/screens/purchases/purchase_register_screen.dart';
import '../presentation/screens/purchases/purchase_list_screen.dart';
import '../presentation/screens/purchases/supplier_register_screen.dart';

//CIERRE DE CAJA
import '../presentation/screens/cash_closing/cash_closing_screen.dart';

//INVENTARIO
import '../presentation/screens/flavor_inventory/flavor_inventory_screen.dart';

/*DE LADO
import '../presentation/screens/inventory/inventory_screen.dart';


*/

// Models
import '../data/models/employee.dart';
import '../data/models/product.dart';
import '../data/models/cash_opening.dart';

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
  static const productRegister = '/product-register';
  static const productEdit = '/product-edit';
  static const productionList = '/production-list';
  static const productionRegister = '/production-register';
  static const reportFilter = '/report-filter';
  static const purchaseRegister = '/purchase-register';
  static const purchaseList = '/purchase-list';
  static const supplierRegister = '/supplier-register';
  static const cashClosing = '/cash-closing';
  static const flavorInventory = '/flavor-inventory';
  //static const inventory = '/inventory';
  // 🔹 Map básico (sin argumentos)
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    employeeList: (context) => const EmployeeListScreen(),
    employeeRegister: (context) => const EmployeeRegisterScreen(),
    flavorRegister: (context) => const FlavorRegisterScreen(),
    productRegister: (context) => const AddProductScreen(),
    productionList: (context) => const ProductionListScreen(),
    productionRegister: (context) => const ProductionRegisterScreen(),
    reportFilter: (context) => const ReportFilterScreen(),
    purchaseRegister: (context) => const PurchaseRegisterScreen(),
    purchaseList: (context) => const PurchaseListScreen(),
    supplierRegister: (context) => const SupplierRegisterScreen(),
    flavorInventory: (context) => const FlavorInventoryScreen(),
    //inventory: (context) => const InventoryScreen(),
  };

  //Manejo de rutas con argumentos
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case employeeMenu:
        final args = settings.arguments as Map<String, dynamic>;

        final employee = args['employee'] as Employee;

        final apertura = args['apertura'] as CashOpening?;

        return MaterialPageRoute(
          builder: (_) =>
              MenuScreen(employee: employee, apertura: apertura),
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

      case salesFlavors:
        final product = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => SalesFlavorsScreen(product: product),
        );

      case AppRoutes.salesProducts:
        final employee = settings.arguments as Employee;

        return MaterialPageRoute(
          builder: (_) => SalesProductsScreen(employee: employee),
        );

      case AppRoutes.productEdit:
        final producto = settings.arguments as Product;

        return MaterialPageRoute(
          builder: (_) => EditProductScreen(producto: producto),
        );

      case AppRoutes.cashClosing:
        final apertura = settings.arguments as CashOpening;

        return MaterialPageRoute(
          builder: (_) => CashClosingScreen(apertura: apertura),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Ruta no encontrada'))),
        );
    }
  }
}
