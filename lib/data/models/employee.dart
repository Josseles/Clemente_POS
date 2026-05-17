enum EmployeeRole { Administrator, Cajero }

class Employee {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String username;
  final String pin;
  final EmployeeRole role;

  Employee({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.username,
    required this.pin,
    required this.role,
  });

  // Convertir objeto Employee a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'pin': pin,
      'role': role.name,
    };
  }

  // Crear un Employee a partir de un Map<String, dynamic>
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String? ?? '',
      address: map['address'] as String? ?? '',
      username: map['username'] as String,
      pin: map['pin'] as String,
      role: EmployeeRole.values.firstWhere(
        (e) => e.name == map['role'],
      ),
    );
  }
}