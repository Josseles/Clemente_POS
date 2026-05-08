import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_textfield.dart';

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
                  AppTextField(
                    hint: "Insumo",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Cantidad unitaria",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Total pagado",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Proveedor",
                    controller: TextEditingController(),
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
