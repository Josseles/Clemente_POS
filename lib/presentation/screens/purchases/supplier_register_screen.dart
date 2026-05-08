import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SupplierRegisterScreen extends StatelessWidget {
  const SupplierRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de proveedores")),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: AppColors.primary,
            child: Column(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresa al historial
                  },
                  child: const Text("Regresar"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Aquí luego conectas la lógica de guardar
                    Navigator.pop(context); // Vuelve al historial
                  },
                  child: const Text("Aceptar"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Panel principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "REGISTRO DE PROVEEDORES",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Producto/marca",
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Número de teléfono",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
