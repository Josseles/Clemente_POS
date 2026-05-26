import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';
import '../menu/widgets/menu_button.dart';
import '../../../core/theme/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.employee.rol == RolEmpleado.Administrador;

    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: const [],
        onConfirm: () {},
        onBack: () => Navigator.pop(context),
      ),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selecciona un producto",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: _products.isEmpty
                            ? const Center(
                                child: Text(
                                  "No hay productos registrados",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                              )
                            : ProductGrid<Product>(
                                items: _products,
                                labelBuilder: (p) => p.nombre,
                                onSelect: (product) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.salesType,
                                    arguments: product.nombre,
                                  );
                                },
                                onLongPress: isAdmin
                                    ? (product) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.productEdit,
                                          arguments: product,
                                        ).then((result) {
                                          if (result == true) {
                                            _loadProducts();
                                          }
                                        });
                                      }
                                    : null,
                              ),
                      ),
                    ],
                  ),
                ),
                if (isAdmin)
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: SizedBox(
                      width: 250,
                      child: MenuButton(
                        text: "NUEVO PRODUCTO",
                        onPressed: () {
                          Navigator.pushNamed(
                                  context, AppRoutes.productRegister)
                              .then((_) => _loadProducts());
                        },
                        color: AppColors.azul,
                        isManager: true,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
