import 'package:flutter/material.dart';

// Core
import '../../../../core/widgets/app_layout.dart';

// Models
import '../../../../data/models/inventory_item.dart';

// Widgets
import 'widgets/inventory_sidebar.dart';
import 'widgets/inventory_search.dart';
import 'widgets/inventory_table.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // 🔹 Datos temporales
    final List<InventoryItem> items = [

      InventoryItem(
        name: "Conos",
        stock: 120,
        category: "Empaque",
      ),

      InventoryItem(
        name: "Vasos",
        stock: 80,
        category: "Empaque",
      ),

      InventoryItem(
        name: "Chocolate",
        stock: 15,
        category: "Sabor",
      ),

      InventoryItem(
        name: "Fresa",
        stock: 9,
        category: "Sabor",
      ),
    ];

    return AppLayout(
      sidebarContent: const InventorySidebar(),

      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "FILTRAR POR",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const InventorySearch(),

            const SizedBox(height: 20),

            InventoryTable(items: items),
          ],
        ),
      ),
    );
  }
}