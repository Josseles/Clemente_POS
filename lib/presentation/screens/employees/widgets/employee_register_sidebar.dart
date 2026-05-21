import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EmployeeRegisterSidebar extends StatelessWidget {
  final VoidCallback onConfirm;
  
  const EmployeeRegisterSidebar({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        //Botón agregar
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.black,
            shape: const StadiumBorder(),
            minimumSize: const Size(140, 50),
          ),
          child: const Text("Confirmar"),
        ),
        const SizedBox(height: 30),
        //Botón regresar
        ElevatedButton(
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

        const SizedBox(height: 30),
      ],
    );
  }
}
