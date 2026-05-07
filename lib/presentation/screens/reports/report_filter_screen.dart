import 'package:clemente_pos/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReportFilterScreen extends StatefulWidget {
  const ReportFilterScreen({super.key});

  @override
  State<ReportFilterScreen> createState() => _ReportFilterScreenState();
}

class _ReportFilterScreenState extends State<ReportFilterScreen> {
  // Simulación de resultados
  List<Map<String, String>> results = [];

  void _generateReport() {
    setState(() {
      // Aquí luego conectas la BD, por ahora simulado
      results = [
        {
          "fecha": "2026-05-06",
          "usuario": "Ami",
          "movimiento": "Venta",
          "producto": "Sabor Fresa",
        },
        {
          "fecha": "2026-05-06",
          "usuario": "Josseles",
          "movimiento": "Compra",
          "producto": "Sabor Mango",
        },
      ];
    });
  }

  void _exportToPDF() {
    // Aquí luego integras librería como `pdf` de Dart
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Exportar a PDF (pendiente)")));
  }

  void _exportToExcel() {
    // Aquí luego integras librería como `excel` de Dart
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Exportar a Excel (pendiente)")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sección de reportes")),
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
                  onPressed: _generateReport,
                  child: const Text("Generar reporte"),
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
                    "FILTRAR POR",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(labelText: "Fecha"),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Usuario"),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Tipo de movimiento",
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: "Producto"),
                  ),
                  const SizedBox(height: 20),

                  // Resultados
                  if (results.isNotEmpty) ...[
                    const Text(
                      "RESULTADOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final item = results[index];
                          return ListTile(
                            title: Text(
                              "${item['movimiento']} - ${item['producto']}",
                            ),
                            subtitle: Text(
                              "Fecha: ${item['fecha']} | Usuario: ${item['usuario']}",
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _exportToPDF,
                          child: const Text("Descargar PDF"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _exportToExcel,
                          child: const Text("Descargar Excel"),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
