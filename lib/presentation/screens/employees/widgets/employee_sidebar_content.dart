import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EmployeeSidebarContent extends StatelessWidget {
  const EmployeeSidebarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // 🔹 Botón agregar
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/employee-register');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            shape: const StadiumBorder(),
          ),
          child: const Text("Agregar nuevo usuario"),
        ),

        const Spacer(),

        // 🔹 Botón regresar
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primary,
            shape: const StadiumBorder(),
          ),
          child: const Text("Regresar"),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}