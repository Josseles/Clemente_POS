import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';
import '../../../routes/app_routes.dart';
import '../../../data/models/employee.dart';

class SalesProductsScreen extends StatefulWidget {
  final Employee employee;

  const SalesProductsScreen({
    super.key,
    required this.employee,
  }); 

  @override
  State<SalesProductsScreen> createState() =>
      _SalesProductsScreenState();
}

class _SalesProductsScreenState extends State<SalesProductsScreen> {
  List<String> selectedProducts = [];

  final List<String> products = [
    "BOLA",
    "MALTEADA",
    "SUNDAE",
    "VASO GRANDE",
    "EXTRA",
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: selectedProducts,
        onConfirm: () {},
        onBack: () => Navigator.pop(context),
        showConfirmButton: true,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: ProductGrid(
          products: products,
          onSelect: (product) {
            Navigator.pushNamed(
              context,
              AppRoutes.salesType,
              arguments: product,
            );
          },
        ),
      ),
    );
  }
}
