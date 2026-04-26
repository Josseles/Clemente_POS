import 'package:flutter/material.dart';

class EmployeeRegisterScreen extends StatelessWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Formulario de registro",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(decoration: const InputDecoration(labelText: "Nombre")),
            TextField(
              decoration: const InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
            ),
            TextField(decoration: const InputDecoration(labelText: "Rol")),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Aquí luego guardas el nuevo empleado
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
