enum RolEmpleado {
  administrador,
  cajero,
}

class Employee {
  final String id;
  final String nombre;
  final String telefono;
  final String direccion;
  final String usuario;
  final String pin;
  final RolEmpleado rol;

  Employee({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.usuario,
    required this.pin,
    required this.rol,
  });

  /// Convierte un objeto Employee a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
      'usuario': usuario,
      'pin': pin,
      'rolEmpleado': rol.name,
    };
  }

  /// Crea un Employee a partir de un Map<String, dynamic>
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'].toString(),
      nombre: map['nombre'] as String,
      telefono: map['telefono'] as String? ?? '',
      direccion: map['direccion'] as String? ?? '',
      usuario: map['usuario'] as String,
      pin: map['pin'] as String,
      rol: RolEmpleado.values.firstWhere(
        (e) => e.name == map['rolEmpleado'],
      ),
    );
  }
}