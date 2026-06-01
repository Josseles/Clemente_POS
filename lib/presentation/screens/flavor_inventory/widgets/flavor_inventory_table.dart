import 'package:flutter/material.dart';

import '../../../../data/models/flavor.dart';

class FlavorInventoryTable
    extends StatelessWidget {
  final List<Flavor> flavors;

  const FlavorInventoryTable({
    super.key,
    required this.flavors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text("Nombre"),
            ),

            DataColumn(
              label: Text("Categoría"),
            ),

            DataColumn(
              label: Text("Stock (L)"),
            ),

            DataColumn(
              label: Text("Activo"),
            ),
          ],

          rows:
              flavors.map((flavor) {
            return DataRow(
              cells: [
                DataCell(
                  Text(flavor.nombre),
                ),

                DataCell(
                  Text(
                    flavor.categoria ==
                            CategoriaSabor
                                .agua
                        ? "Agua"
                        : "Crema",
                  ),
                ),

                DataCell(
                  Text(
                    flavor.stockLitros
                        .toStringAsFixed(
                      2,
                    ),
                  ),
                ),

                DataCell(
                  Text(
                    flavor.activo
                        ? "Sí"
                        : "No",
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}