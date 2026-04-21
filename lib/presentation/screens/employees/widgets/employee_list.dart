import 'package:flutter/material.dart';
import '../../../../data/models/employee.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;

  const EmployeeList({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final emp = employees[index];

        return ListTile(
          title: Text(emp.name),
          subtitle: Text("${emp.role.name} - ${emp.phone}"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // futuro: detalle o editar
          },
        );
      },
    );
  }
}