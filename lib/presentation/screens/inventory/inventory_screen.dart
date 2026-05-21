import 'package:flutter/material.dart';

// Core
import '../../../../core/widgets/app_layout.dart';

// Models
import '../../../../data/models/inventory_item.dart';
import '../../../../data/repositories/inventory_repository.dart';

// Widgets
import 'widgets/inventory_sidebar.dart';
import 'widgets/inventory_search.dart';
import 'widgets/inventory_table.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryRepository _repository = InventoryRepository();
  late Future<List<InventoryItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _itemsFuture = _repository.obtenerTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: const InventorySidebar(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: FutureBuilder<List<InventoryItem>>(
                future: _itemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay artículos en el inventario',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return InventoryTable(items: snapshot.data!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}