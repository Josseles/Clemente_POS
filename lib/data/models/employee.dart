enum EmployeeRole { employee, manager }

class Employee {
  final String id;
  final String name;
  final EmployeeRole role;
  final String phone;

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.phone,
  });
}