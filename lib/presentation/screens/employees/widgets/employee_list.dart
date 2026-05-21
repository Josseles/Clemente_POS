import 'package:flutter/material.dart';
import '../../../../data/models/employee.dart';

class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final void Function(Employee employee)? onTap;

  const EmployeeList({
    super.key,
    required this.employees,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return const Center(
        child: Text('No hay empleados registrados'),
      );
    }

    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final empleado = employees[index];

        return ListTile(
          title: Text(empleado.nombre),
          subtitle: Text(
            '${empleado.rol.name} • ${empleado.telefono}',
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            if (onTap != null) {
              onTap!(empleado);
            }
          },
        );
      },
    );
  }
}