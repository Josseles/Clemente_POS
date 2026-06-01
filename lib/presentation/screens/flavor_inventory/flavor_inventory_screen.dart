import 'package:flutter/material.dart';

import '../../../core/widgets/app_layout.dart';

import '../../../data/models/flavor.dart';
import '../../../data/repositories/flavor_repository.dart';

import 'widgets/flavor_inventory_sidebar.dart';
import 'widgets/flavor_inventory_table.dart';

class FlavorInventoryScreen extends StatefulWidget {
  const FlavorInventoryScreen({super.key});

  @override
  State<FlavorInventoryScreen> createState() => _FlavorInventoryScreenState();
}

class _FlavorInventoryScreenState extends State<FlavorInventoryScreen> {
  final FlavorRepository _repository = FlavorRepository();

  final TextEditingController _searchController = TextEditingController();

  List<Flavor> _allFlavors = [];
  List<Flavor> _filteredFlavors = [];

  CategoriaSabor? _categoriaFiltro;
  bool? _activoFiltro;

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
        _allFlavors = data;
        _filteredFlavors = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    final search = _searchController.text.toLowerCase();

    setState(() {
      _filteredFlavors = _allFlavors.where((flavor) {
        final nombreOk = flavor.nombre.toLowerCase().contains(search);

        final categoriaOk =
            _categoriaFiltro == null || flavor.categoria == _categoriaFiltro;

        final activoOk =
            _activoFiltro == null || flavor.activo == _activoFiltro;

        return nombreOk && categoriaOk && activoOk;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: FlavorInventorySidebar(
        categoriaFiltro: _categoriaFiltro,
        activoFiltro: _activoFiltro,

        onCategoriaChanged: (value) {
          _categoriaFiltro = value;
          _applyFilters();
        },

        onActivoChanged: (value) {
          _activoFiltro = value;
          _applyFilters();
        },
      ),

      child: Padding(
        padding: const EdgeInsets.all(30),

        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _searchController,

                    onChanged: (_) => _applyFilters(),

                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),

                      hintText: 'Buscar sabor',

                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: _filteredFlavors.isEmpty
                        ? Center(
                            child: Text(
                              _allFlavors.isEmpty
                                  ? "No hay sabores registrados."
                                  : "No hay sabores que coincidan con los filtros.",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : FlavorInventoryTable(flavors: _filteredFlavors),
                  ),
                ],
              ),
      ),
    );
  }
}
