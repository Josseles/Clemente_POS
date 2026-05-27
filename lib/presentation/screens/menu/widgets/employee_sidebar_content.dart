import 'package:clemente_pos/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/employee.dart';

class EmployeeSidebarContent extends StatelessWidget {
  final Employee employee;

  const EmployeeSidebarContent({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            // Lógica de ayuda
          },
          child: const Text(
            "Ayuda",
            style: TextStyle(color: AppColors.black, fontSize: 30),
          ),
        ),

        const SizedBox(height: 20),

        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white24,
          child: Icon(
            employee.rol == RolEmpleado.Administrador
                ? Icons.admin_panel_settings
                : Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "Usuario:\n${employee.nombre}\nRol:\n${employee.rol == RolEmpleado.Administrador ? 'Admin' : 'Cajero'}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.white, fontSize: 18),
        ),

        const Spacer(),

        /* Podríamos agregar botones específicos según el rol aquí
        if (employee.rol == RolEmpleado.Administrador) ...[
          const Text(
            "MODO ADMIN",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
        ],
        */

        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            "Cerrar\nsesión",
            style: TextStyle(color: AppColors.black, fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
