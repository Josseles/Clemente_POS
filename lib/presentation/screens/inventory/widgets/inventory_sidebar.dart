import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class InventorySidebar extends StatelessWidget {
  const InventorySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      color: AppColors.primary,

      child: Column(
        children: [

          const SizedBox(height: 40),

          const Text(
            "Inventario",

            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 18,
              ),
            ),

            child: const Text("Aceptar"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}