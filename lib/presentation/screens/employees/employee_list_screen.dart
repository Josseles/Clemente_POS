import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/app_layout.dart';

// Models
import '../../../data/models/employee.dart';

// Widgets
import 'widgets/employee_sidebar_content.dart';
import 'widgets/employee_list.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Datos de prueba
    final List<Employee> employees = [
      Employee(
        id: "1",
        name: "Juan Pérez",
        role: EmployeeRole.employee,
        phone: "6671234567",
      ),
      Employee(
        id: "2",
        name: "Ana López",
        role: EmployeeRole.manager,
        phone: "6679876543",
      ),
    ];

    return AppLayout(
      sidebarContent: const EmployeeSidebarContent(),

      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "Registro de usuarios",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                child: EmployeeList(employees: employees),
              ),
            ),
          ],
        ),
      ),
    );
  }
}