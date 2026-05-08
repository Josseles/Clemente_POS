import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/app_layout.dart';

// Widgets
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';

class SalesFlavorsScreen extends StatefulWidget {
  final String product;

  const SalesFlavorsScreen({super.key, required this.product});

  @override
  State<SalesFlavorsScreen> createState() => _SalesFlavorsScreenState();
}

class _SalesFlavorsScreenState extends State<SalesFlavorsScreen> {
  // 🔹 Sabores de prueba
  final List<String> flavors = [
    "CHOCOLATE",
    "VAINILLA",
    "FRESA",
    "OREO",
    "MANGO",
    "LIMÓN",
    "NUEZ",
    "CAFÉ",
  ];

  // 🔹 Sabores seleccionados
  List<String> selectedFlavors = [];

  // 🔹 Máximo de sabores
  int get maxFlavors {
    switch (widget.product) {
      case "BOLA":
        return 2;

      case "MALTEADA":
        return 1;

      case "SUNDAE":
        return 2;

      default:
        return 1;
    }
  }

  void selectFlavor(String flavor) {
    // 🔹 Evitar pasar límite
    if (selectedFlavors.length >= maxFlavors) {
      return;
    }

    setState(() {
      selectedFlavors.add(flavor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: selectedFlavors,

        onConfirm: () {
          Navigator.pop(context);
        },

        onBack: () {
          Navigator.pop(context);
        },

        showConfirmButton: true,

        confirmText: "AGREGAR",
      ),

      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Título
            Text(
              "Selecciona sabores (${selectedFlavors.length}/$maxFlavors)",

              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // 🔹 Grid de sabores
            Expanded(
              child: ProductGrid(
                products: flavors,

                onSelect: (flavor) {
                  selectFlavor(flavor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
