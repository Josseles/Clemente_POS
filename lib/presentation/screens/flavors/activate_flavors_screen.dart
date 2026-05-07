import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Models
import '../../../data/models/employee.dart';
import '../../../data/models/flavor.dart';

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
  List<Flavor> flavors = [
    Flavor(id: "1", name: "Chocolate"),
    Flavor(id: "2", name: "Vainilla"),
    Flavor(id: "3", name: "Fresa"),
    Flavor(id: "4", name: "Mango"),
    Flavor(id: "5", name: "Oreo"),
  ];

  void toggleFlavor(int index) {
    setState(() {
      flavors[index].isSelected =
          !flavors[index].isSelected;
    });
  }

  List<String> get selectedFlavors {
    return flavors
        .where((f) => f.isSelected)
        .map((f) => f.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: const FlavorSidebarContent(),

      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            // 🔹 Panel izquierdo
            SelectedFlavorsPanel(
              selectedFlavors: selectedFlavors,
            ),

            const SizedBox(width: 30),

            // 🔹 Lista
            Expanded(
              child: FlavorList(
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