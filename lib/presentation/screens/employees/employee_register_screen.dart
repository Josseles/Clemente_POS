import 'package:flutter/material.dart';
import '../../../data/models/employee.dart';
import '../../../data/repositories/employee_repository.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Widgets
import 'widgets/employee_register_sidebar.dart';

class EmployeeRegisterScreen extends StatefulWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  State<EmployeeRegisterScreen> createState() => _EmployeeRegisterScreenState();
}

class _EmployeeRegisterScreenState extends State<EmployeeRegisterScreen> {
  final _repository = EmployeeRepository();
  
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  
  RolEmpleado _selectedRol = RolEmpleado.Cajero;

  Future<void> _registerEmployee() async {
    final nombre = _nombreController.text.trim();
    final telefono = _telefonoController.text.trim();
    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    if (nombre.isEmpty || pin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nombre y PIN son obligatorios")),
      );
      return;
    }

    if (pin != confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Los PIN no coinciden")),
      );
      return;
    }

    final newEmployee = Employee(
      nombre: nombre,
      telefono: telefono,
      pin: pin,
      rol: _selectedRol,
    );

    try {
      await _repository.insertar(newEmployee);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Empleado registrado con éxito")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al registrar: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: EmployeeRegisterSidebar(onConfirm: _registerEmployee),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            // 🔹 Título
            const Text(
              "Formulario de registro",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 🔹 Panel blanco
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Nombre
                      const Text("Nombre"),
                      const SizedBox(height: 5),
                      buildTextField(controller: _nombreController),
                      const SizedBox(height: 15),

                      // 🔹 Teléfono
                      const Text("Teléfono"),
                      const SizedBox(height: 5),
                      buildTextField(
                        controller: _telefonoController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),

                      // 🔹 Rol
                      const Text("Rol"),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<RolEmpleado>(
                        value: _selectedRol,
                        items: RolEmpleado.values.map((rol) {
                          return DropdownMenuItem(
                            value: rol,
                            child: Text(rol.name),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedRol = val);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // 🔹 Contraseña (PIN)
                      const Text("Contraseña (PIN)"),
                      const SizedBox(height: 5),
                      buildTextField(
                        controller: _pinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),

                      // 🔹 Confirmar contraseña
                      const Text("Confirmar contraseña"),
                      const SizedBox(height: 5),
                      buildTextField(
                        controller: _confirmPinController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 TextField reutilizable
  Widget buildTextField({
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
