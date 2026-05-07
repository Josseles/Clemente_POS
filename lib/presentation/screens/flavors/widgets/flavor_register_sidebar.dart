import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class FlavorRegisterSidebar extends StatelessWidget {
  const FlavorRegisterSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        // 🔹 Regresar
        SizedBox(
          width: 140,

          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.black,
              shape: const StadiumBorder(),
              minimumSize: const Size(140, 50),
            ),

            child: const Text("Regresar"),
          ),
        ),  
        const SizedBox(height: 20),
      ],
    );
  }
}
