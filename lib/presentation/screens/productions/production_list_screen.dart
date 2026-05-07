import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class ProductionListScreen extends StatelessWidget {
  const ProductionListScreen({super.key});

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
                    Navigator.pushNamed(context, AppRoutes.productionRegister);
                  },
                  child: const Text("Agregar nuevo lote"),
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
                    "HISTORIAL DE PRODUCCIONES",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Buscar producción",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(title: Text("Producción XXXXXX")),
                        ListTile(title: Text("Producción XXXXXX")),
                        ListTile(title: Text("Producción XXXXXX")),
                        ListTile(title: Text("Producción XXXXXX")),
                      ],
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
