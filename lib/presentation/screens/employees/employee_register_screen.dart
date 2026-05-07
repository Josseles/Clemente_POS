import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Widgets
import 'widgets/employee_register_sidebar.dart';

class EmployeeRegisterScreen extends StatelessWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: const EmployeeRegisterSidebar(),

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

                    buildTextField(),

                    const SizedBox(height: 15),

                    // 🔹 Teléfono
                    const Text("Teléfono"),
                    const SizedBox(height: 5),

                    buildTextField(keyboardType: TextInputType.phone),

                    const SizedBox(height: 15),

                    // 🔹 Rol
                    const Text("Rol"),
                    const SizedBox(height: 5),

                    buildTextField(),

                    const SizedBox(height: 15),

                    // 🔹 Contraseña
                    const Text("Contraseña"),
                    const SizedBox(height: 5),

                    buildTextField(obscureText: true),

                    const SizedBox(height: 15),

                    // 🔹 Confirmar contraseña
                    const Text("Confirmar contraseña"),
                    const SizedBox(height: 5),

                    buildTextField(obscureText: true),

                    const Spacer(),
                  ],
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
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
