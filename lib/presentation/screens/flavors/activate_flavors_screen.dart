import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Models
import '../../../data/models/employee.dart';
import '../../../data/models/flavor.dart';
import '../../../data/repositories/flavor_repository.dart';

// Widgets
import 'widgets/flavor_list.dart';
import 'widgets/selected_flavors_panels.dart';
import 'widgets/flavor_sidebar_content.dart';

class ActivateFlavorsScreen extends StatefulWidget {
  final Employee employee;

  const ActivateFlavorsScreen({
    super.key,
    required this.employee,
  });

  @override
  State<ActivateFlavorsScreen> createState() =>
      _ActivateFlavorsScreenState();
}

class _ActivateFlavorsScreenState
    extends State<ActivateFlavorsScreen> {
  final FlavorRepository _repository = FlavorRepository();
  List<Flavor> flavors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFlavors();
  }

  Future<void> _loadFlavors() async {
    try {
      final data = await _repository.obtenerTodos();
      setState(() {
        flavors = data;
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

  Future<void> toggleFlavor(int index) async {
    final flavor = flavors[index];
    final updatedFlavor = flavor.copyWith(activo: !flavor.activo);

    try {
      await _repository.actualizar(updatedFlavor);
      setState(() {
        flavors[index] = updatedFlavor;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al actualizar sabor: $e")),
        );
      }
    }
  }

  List<String> get selectedFlavors {
    return flavors
        .where((f) => f.activo)
        .map((f) => f.nombre)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: FlavorSidebarContent(onFlavorAdded: _loadFlavors,),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Row(
                children: [
                  // 🔹 Panel izquierdo
                  SelectedFlavorsPanel(
                    selectedFlavors: selectedFlavors,
                  ),

                  const SizedBox(width: 30),

                  // 🔹 Lista
                  Expanded(
                    child: flavors.isEmpty
                        ? const Center(child: Text("No hay sabores registrados"))
                        : FlavorList(
                            flavors: flavors,
                            onToggle: toggleFlavor,
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}