import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/app_layout.dart';

// Widgets
import 'widgets/sales_sidebar.dart';
import 'widgets/product_grid.dart';

// Data
import '../../../data/models/flavor.dart';
import '../../../data/repositories/flavor_repository.dart';

class SalesFlavorsScreen extends StatefulWidget {
  final String product;

  const SalesFlavorsScreen({super.key, required this.product});

  @override
  State<SalesFlavorsScreen> createState() => _SalesFlavorsScreenState();
}

class _SalesFlavorsScreenState extends State<SalesFlavorsScreen> {
  final FlavorRepository _flavorRepository = FlavorRepository();
  List<Flavor> _flavors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFlavors();
  }

  Future<void> _loadFlavors() async {
    try {
      // Cargamos solo los sabores activos para la venta
      final flavors = await _flavorRepository.obtenerActivos();
      setState(() {
        _flavors = flavors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cargar sabores: $e")),
        );
      }
    }
  }

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

  void selectFlavor(Flavor flavor) {
    // 🔹 Evitar pasar límite
    if (selectedFlavors.length >= maxFlavors) {
      return;
    }

    setState(() {
      selectedFlavors.add(flavor.nombre);
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _flavors.isEmpty
                      ? const Center(
                          child: Text(
                            "No hay sabores activos disponibles",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ProductGrid<Flavor>(
                          items: _flavors,
                          labelBuilder: (f) => f.nombre,
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
