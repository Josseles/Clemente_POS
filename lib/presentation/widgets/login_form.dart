import 'package:flutter/material.dart';
import '../../data/models/employee.dart';
import '../../routes/app_routes.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();

  void _login() {
    final username = _userController.text.trim();

    // Validar que no esté vacío
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa un usuario válido")),
      );
      return;
    }

    // Lista de prueba
    final employees = [
      Employee(
        id: "1",
        name: "Juan Perez",
        role: EmployeeRole.employee,
        phone: "6671234567",
      ),
      Employee(
        id: "2",
        name: "Ana Lopez",
        role: EmployeeRole.manager,
        phone: "6679876543",
      ),
    ];

    try {
      // Buscar empleado por nombre (ignora mayúsculas/minúsculas)
      final employee = employees.firstWhere(
        (e) => e.name.toLowerCase() == username.toLowerCase(),
      );

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.employeeMenu,
        arguments: employee,
      );
    } catch (e) {
      // Si no existe, mostrar mensaje
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Usuario no encontrado")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bienvenido",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _userController, // agregado
                decoration: InputDecoration(
                  hintText: "Usuario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login, //  cambiado
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE32E8F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Iniciar sesión",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
