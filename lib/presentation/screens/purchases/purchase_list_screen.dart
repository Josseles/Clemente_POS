import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_textfield.dart';

class PurchaseListScreen extends StatelessWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de compras")),
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
                    Navigator.pushNamed(context, AppRoutes.purchaseRegister);
                  },
                  child: const Text("Agregar nueva compra"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.supplierRegister);
                  },
                  child: const Text("Agregar proveedor"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Regresa al menú
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
                    "HISTORIAL DE COMPRAS",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Buscador
                  AppTextField(
                    hint: "Buscar compra",
                    controller: TextEditingController(),
                  ),

                  const SizedBox(height: 20),
                  // Lista simulada
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const ListTile(title: Text("XXXXXX"));
                      },
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
