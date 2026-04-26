import 'package:flutter/material.dart';

import 'widgets/employee_sidebar_content.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/menu_button.dart';
import '../../../data/models/employee.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class EmployeeMenuScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeMenuScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: const EmployeeSidebarContent(),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // fila extra SOLO si es manager (arriba)
                  if (employee.role == EmployeeRole.manager) ...[
                    Row(
                      children: [
                        Expanded(
                          child: MenuButton(
                            text: "EMPLEADOS",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.employeeList,
                              );
                            },
                            color: AppColors.azul,
                            isManager: true, // más compacto
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: MenuButton(
                            text: "SABORES DEL DÍA",
                            onPressed: () {},
                            color: AppColors.azul,
                            isManager: true, // más compacto
                          ),
                        ),
                      ],
                    ),
                  ],

                  // fila 1
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(text: "VENTA", onPressed: () {}),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(text: "SABORES", onPressed: () {}),
                      ),
                    ],
                  ),

                  // fila 2
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(text: "INVENTARIO", onPressed: () {}),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(text: "REPORTES", onPressed: () {}),
                      ),
                    ],
                  ),

                  // fila 3
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(text: "COMPRAS", onPressed: () {}),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(text: "PRODUCCIÓN", onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
