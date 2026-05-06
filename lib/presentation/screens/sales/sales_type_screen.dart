import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';
import '../../../routes/app_routes.dart';

class SalesTypeScreen extends StatelessWidget {
  final String product;

  const SalesTypeScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: const [],
        onConfirm: () {},
        onBack: () => Navigator.pop(context),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.salesFlavors,
                  arguments: product,
                );
              },
              child: const Text("Cono"),
            ),
            const SizedBox(width: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.salesFlavors,
                  arguments: product,
                );
              },
              child: const Text("Vaso"),
            ),
          ],
        ),
      ),
    );
  }
}
