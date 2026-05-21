enum RolEmpleado {
  Administrador,
  Cajero,
}

class Employee {
  final int? id;
  final String nombre;
  final String telefono;
  final String pin;
  final RolEmpleado rol;

  Employee({
    this.id,
    required this.nombre,
    required this.telefono,
    required this.pin,
    required this.rol,
  });

  /// Convierte un objeto Employee a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'pin': pin,
      'rolEmpleado': rol.name,
    };
  }

  /// Crea un Employee a partir de un Map<String, dynamic>
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      telefono: map['telefono'] as String? ?? '',
      pin: map['pin'] as String,
      rol: RolEmpleado.values.firstWhere(
        (e) => e.name == map['rolEmpleado'],
        orElse: () => RolEmpleado.Cajero,
      ),
    );
  }
}