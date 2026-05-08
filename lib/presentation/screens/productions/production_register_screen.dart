import 'package:clemente_pos/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/app_textfield.dart';

class ProductionRegisterScreen extends StatelessWidget {
  const ProductionRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de producciones")),
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
                    // Aquí luego guardas la producción
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
                    "Formulario de producción",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    hint: "Sabor",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Cantidad en litros",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Fecha de producción",
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    hint: "Costo de producción",
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
