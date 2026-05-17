import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';
import '../../../routes/app_routes.dart';
import '../../../data/models/employee.dart';


class SalesProductsScreen extends StatefulWidget {
  final Employee employee;

  const SalesProductsScreen({super.key, required this.employee});

  @override
  State<SalesProductsScreen> createState() => _SalesProductsScreenState();
}

class _SalesProductsScreenState extends State<SalesProductsScreen> {
  List<String> selectedProducts = [];

  final List<String> products = [
    "BOLA",
    "MALTEADA",
    "SUNDAE",
    "VASO GRANDE",
    "EXTRA",
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: selectedProducts,
        onConfirm: () {
          // 🔹 Guardamos contexto principal
          final mainContext = context;

          showDialog(
            context: context,

            builder: (_) {
              final TextEditingController moneyController =
                  TextEditingController();

              String paymentMethod = "Efectivo";

              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: Colors.yellow[200],

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    title: const Text(
                      "Confirmar venta",

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    content: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        // 🔹 Total
                        const Text(
                          "Total: \$120",

                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🔹 Método de pago
                        DropdownButtonFormField<String>(
                          initialValue: paymentMethod,

                          decoration: const InputDecoration(
                            labelText: "Método de pago",
                            border: OutlineInputBorder(),
                          ),

                          items: const [
                            DropdownMenuItem(
                              value: "Efectivo",
                              child: Text("Efectivo"),
                            ),

                            DropdownMenuItem(
                              value: "Tarjeta",
                              child: Text("Tarjeta"),
                            ),

                            DropdownMenuItem(
                              value: "Transferencia",
                              child: Text("Transferencia"),
                            ),
                          ],

                          onChanged: (value) {
                            setState(() {
                              paymentMethod = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        // 🔹 Dinero recibido
                        TextField(
                          controller: moneyController,

                          keyboardType: TextInputType.number,

                          decoration: const InputDecoration(
                            labelText: "Dinero recibido",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),

                    actions: [
                      // 🔹 Cancelar
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Cancelar",

                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                      // 🔹 Confirmar
                      ElevatedButton(
                        onPressed: () {
                          final double received =
                              double.tryParse(moneyController.text) ?? 0;

                          const double total = 120;

                          final double change = received - total;

                          // 🔹 Cerramos primer dialog
                          Navigator.pop(context);

                          // 🔹 Abrimos popup final
                          showDialog(
                            context: mainContext,

                            builder: (_) => AlertDialog(
                              backgroundColor: Colors.yellow[200],

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),

                              title: const Text("Venta completada"),

                              content: Text(
                                "Cambio: \$${change.toStringAsFixed(2)}\n\n"
                                "Método: $paymentMethod",
                              ),

                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(mainContext);
                                  },

                                  child: const Text("Aceptar"),
                                ),
                              ],
                            ),
                          );
                        },

                        child: const Text("Confirmar"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        onBack: () => Navigator.pop(context),
        showConfirmButton: true,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: ProductGrid(
          products: products,
          onSelect: (product) {
            // Solo BOLA necesita elegir tipo
            if (product == "BOLA") {
              Navigator.pushNamed(
                context,
                AppRoutes.salesType,
                arguments: product,
              );
            }
            // Los demás van directo a sabores
            else {
              Navigator.pushNamed(
                context,
                AppRoutes.salesFlavors,
                arguments: product,
              );
            }
          },
        ),
      ),
    );
  }
}
