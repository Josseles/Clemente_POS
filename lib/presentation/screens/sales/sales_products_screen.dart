import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';
import '../../../routes/app_routes.dart';
import '../../../data/models/employee.dart';
import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';


class SalesProductsScreen extends StatefulWidget {
  final Employee employee;

  const SalesProductsScreen({super.key, required this.employee});

  @override
  State<SalesProductsScreen> createState() => _SalesProductsScreenState();
}

class _SalesProductsScreenState extends State<SalesProductsScreen> {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productRepository.obtenerTodos();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cargar productos: $e")),
        );
      }
    }
  }

  List<String> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: selectedProducts,
        onConfirm: () {
          // ... rest of confirm logic ...

