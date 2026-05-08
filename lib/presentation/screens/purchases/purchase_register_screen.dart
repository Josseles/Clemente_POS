import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
 

class PurchaseRegisterScreen extends StatelessWidget {
  const PurchaseRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de compras nuevas")),
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
                    Navigator.pop(context);
                  },
                  child: const Text("Regresar"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    "REGISTRO DE COMPRAS NUEVAS",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: "Insumo"),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Cantidad unitaria",
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Total pagado",
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Proveedor"),
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
