import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SelectedFlavorsPanel extends StatelessWidget {
  final List<String> selectedFlavors;

  const SelectedFlavorsPanel({
    super.key,
    required this.selectedFlavors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      color: AppColors.primary,
      child: Column(
        children: [
          const Text(
            "Sabores del día",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              children: selectedFlavors
                  .map((flavor) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          flavor,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
          ),

          ElevatedButton(
            onPressed: () {},
            child: const Text("Aceptar"),
          ),
        ],
      ),
    );
  }
}