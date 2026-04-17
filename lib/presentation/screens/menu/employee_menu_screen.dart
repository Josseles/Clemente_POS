import 'package:flutter/material.dart';

import 'widgets/employee_sidebar_content.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/menu_button.dart';

class EmployeeMenuScreen extends StatelessWidget {
  const EmployeeMenuScreen({super.key});

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

                  //const SizedBox(height: 30),

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

                  //const SizedBox(height: 30),

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
