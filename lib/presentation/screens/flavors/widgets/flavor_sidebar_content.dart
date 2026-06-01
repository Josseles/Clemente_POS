import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class FlavorSidebarContent extends StatelessWidget {
  final Future<void> Function() onFlavorAdded;

  const FlavorSidebarContent({
    super.key,
    required this.onFlavorAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () async {
            final result =
                await Navigator.pushNamed(
              context,
              AppRoutes.flavorRegister,
            );

            if (result == true) {
              await onFlavorAdded();
            }
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.black,
            shape: const StadiumBorder(),
          ),

          child: const Text(
            "Agregar nuevo sabor",
          ),
        ),

        const Spacer(),

        // 🔹 Botón regresar
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.black,
            shape: const StadiumBorder(),
          ),
          child: const Text("Regresar"),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}