import 'package:flutter/material.dart';

import 'widgets/employee_sidebar_content.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/menu_button.dart';
import '../../../data/models/employee.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class EmployeeMenuScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeMenuScreen({
    super.key,
    required this.employee,
  });

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
                  // Fila adicional solo para administradores
                  if (employee.rol ==
                      RolEmpleado.Administrador) ...[
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
                            isManager: true,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: MenuButton(
                            text:
                                "ACTIVAR SABORES DEL DÍA",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.activateFlavors,
                                arguments: employee,
                              );
                            },
                            color: AppColors.azul,
                            isManager: true,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Fila 1
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(
                          text: "VENTA",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.salesProducts,
                              arguments: employee,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(
                          text: "SABORES",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  // Fila 2
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(
                          text: "INVENTARIO",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.inventory,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(
                          text: "REPORTES",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.reportFilter,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Fila 3
                  Row(
                    children: [
                      Expanded(
                        child: MenuButton(
                          text: "COMPRAS",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.purchaseList,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: MenuButton(
                          text: "PRODUCCIÓN",
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.productionList,
                            );
                          },
                        ),
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