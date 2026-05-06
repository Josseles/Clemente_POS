import 'package:flutter/material.dart';

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
          child: Text(product),
        );
      },
    );
  }
}