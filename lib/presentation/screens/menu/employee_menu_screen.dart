import 'package:flutter/material.dart';

import 'widgets/employee_sidebar_content.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/menu_button.dart';
import '../../../data/models/employee.dart';

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
                children: [
                  // fila 1
                  Expanded(
                    child: Row(
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
                  ),

                  // fila 2
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: MenuButton(
                            text: "INVENTARIO",
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: MenuButton(text: "REPORTES", onPressed: () {}),
                        ),
                      ],
                    ),
                  ),

                  // fila 3
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: MenuButton(text: "COMPRAS", onPressed: () {}),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: MenuButton(
                            text: "PRODUCCIÓN",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),

                  // fila extra SOLO si es gerente
                  if (employee.role == EmployeeRole.manager) ...[
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: MenuButton(
                              text: "REGISTRO DE USUARIO",
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: MenuButton(
                              text: "SABORES DEL DÍA",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
