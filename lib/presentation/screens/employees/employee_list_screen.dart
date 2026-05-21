import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Models
import '../../../data/models/employee.dart';
import '../../../data/repositories/employee_repository.dart';

// Widgets
import 'widgets/employee_sidebar_content.dart';
import 'widgets/employee_list.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeRepository _repository = EmployeeRepository();
  late Future<List<Employee>> _employeesFuture;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  void _loadEmployees() {
    setState(() {
      _employeesFuture = _repository.obtenerTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: const EmployeeSidebarContent(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "Registro de usuarios",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                child: FutureBuilder<List<Employee>>(
                  future: _employeesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hay empleados registrados',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }

                    return EmployeeList(
                      employees: snapshot.data!,
                      onTap: (employee) {
                        // Aquí se podría implementar la edición del empleado
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
