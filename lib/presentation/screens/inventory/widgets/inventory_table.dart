import 'package:flutter/material.dart';
import '../../../../../data/models/inventory_item.dart';

class InventoryTable extends StatelessWidget {

  final List<InventoryItem> items;

  const InventoryTable({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
        ),

        child: Column(
          children: [

            // 🔹 Header
            Container(
              color: Colors.blueGrey[200],
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),

              child: const Row(
                children: [

                  Expanded(
                    child: Center(
                      child: Text(
                        "Producto",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        "Categoría",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        "Stock",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Tabla
            Expanded(
              child: ListView.builder(
                itemCount: items.length,

                itemBuilder: (_, index) {

                  final item = items[index];

                  return Container(
                    color: Colors.yellow[200],
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),

                    child: Row(
                      children: [

                        Expanded(
                          child: Center(
                            child: Text(item.name),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(item.category),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              item.stock.toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}