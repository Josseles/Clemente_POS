import 'package:clemente_pos/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmployeeSidebarContent extends StatelessWidget {
  const EmployeeSidebarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {},
          child: const Text("Ayuda", style: TextStyle(color: AppColors.black, fontSize: 30)),
        ),

        const SizedBox(height: 20),

        const CircleAvatar(radius: 50),

        const SizedBox(height: 20),

        const Text(
          "Usuario:\nXXXXX\nID:\nXXXXX",
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),

        const Spacer(),

        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text("Cerrar\nsesión", style: TextStyle(color: AppColors.black, fontSize: 30)),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}