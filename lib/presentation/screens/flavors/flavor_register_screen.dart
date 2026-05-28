import 'package:flutter/material.dart';
import '../../../data/models/flavor.dart';
import '../../../data/repositories/flavor_repository.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Widgets
import 'widgets/flavor_register_sidebar.dart';

class FlavorRegisterScreen extends StatefulWidget {
  const FlavorRegisterScreen({super.key});

  @override
  State<FlavorRegisterScreen> createState() => _FlavorRegisterScreenState();
}

class _FlavorRegisterScreenState extends State<FlavorRegisterScreen> {
  final _repository = FlavorRepository();
  final _nombreController = TextEditingController();
  CategoriaSabor _selectedCategoria = CategoriaSabor.crema;

  Future<void> _saveFlavor() async {
    final nombre = _nombreController.text.trim();

    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("El nombre del sabor es obligatorio")),
      );
      return;
    }

    final newFlavor = Flavor(
      id: null,
      nombre: nombre,
      categoria: _selectedCategoria,
      stockLitros: 0,
      activo: false,
    );

    try {
      await _repository.insertar(newFlavor);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sabor registrado con éxito")),
        );
        _nombreController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al registrar: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: const FlavorRegisterSidebar(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "Registro de sabores",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sabor",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    buildTextField(controller: _nombreController),
                    const SizedBox(height: 40),
                    const Text(
                      "Tipo de sabor",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 400,
                      child: DropdownButtonFormField<CategoriaSabor>(
                        value: _selectedCategoria,
                        items: CategoriaSabor.values.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat == CategoriaSabor.agua ? "Agua" : "Crema"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedCategoria = val);
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: _saveFlavor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: const StadiumBorder(),
                          minimumSize: const Size(140, 50),
                        ),
                        child: const Text("Aceptar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required TextEditingController controller}) {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
