import 'package:flutter/material.dart';
import 'package:clemente_pos/core/theme/app_colors.dart';

class ProductGrid extends StatelessWidget {
  final List<String> products;
  final Function(String) onSelect;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (_, index) {
        final product = products[index];

        return ElevatedButton(
          onPressed: () => onSelect(product),

          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            elevation: 4,
          ),

          child: Text(
            product,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
