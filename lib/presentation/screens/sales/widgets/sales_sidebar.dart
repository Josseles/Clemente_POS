import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SalesSidebar extends StatelessWidget {
  final List<String> selectedProducts;
  final VoidCallback onConfirm;
  final VoidCallback onBack;
  final bool showConfirmButton;

  const SalesSidebar({
    super.key,
    required this.selectedProducts,
    required this.onConfirm,
    required this.onBack,
    this.showConfirmButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.primary,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onBack,
            child: const Text("VOLVER"),
          ),

          const SizedBox(height: 20),

          const Text(
            "Productos seleccionados",
            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: selectedProducts
                  .map((p) => Text(
                        "• $p",
                        style: const TextStyle(color: Colors.white),
                      ))
                  .toList(),
            ),
          ),

          if (showConfirmButton) ...[
            ElevatedButton(
              onPressed: onConfirm,
              child: const Text("CONFIRMAR VENTA"),
            ),
          ],
        ],
      ),
    );
  }
}