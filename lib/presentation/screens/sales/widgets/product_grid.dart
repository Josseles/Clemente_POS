import 'package:flutter/material.dart';
import 'package:clemente_pos/core/theme/app_colors.dart';

class ProductGrid<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T) onSelect;
  final void Function(T)? onLongPress;

  const ProductGrid({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onSelect,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (_, index) {
        final item = items[index];

        return ElevatedButton(
          onPressed: () => onSelect(item),
          onLongPress: onLongPress != null ? () => onLongPress!(item) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
          ),
          child: Text(
            labelBuilder(item),
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
