import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import '../menu/widgets/employee_sidebar_content.dart';
import 'widgets/flavor_list.dart';
import 'widgets/selected_flavors_panels.dart';

class ActivateFlavorsScreen extends StatefulWidget {
  const ActivateFlavorsScreen({super.key});

  @override
  State<ActivateFlavorsScreen> createState() => _ActivateFlavorsScreenState();
}

class _ActivateFlavorsScreenState extends State<ActivateFlavorsScreen> {
  List<Map<String, dynamic>> flavors = [
    {"name": "Chocolate", "selected": false},
    {"name": "Vainilla", "selected": false},
    {"name": "Fresa", "selected": false},
    {"name": "Mango", "selected": false},
    {"name": "Oreo", "selected": false},
  ];

  void toggleFlavor(int index) {
    setState(() {
      flavors[index]["selected"] = !flavors[index]["selected"];
    });
  }

  List<String> get selectedFlavors {
    return flavors
        .where((f) => f["selected"])
        .map((f) => f["name"] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: const EmployeeSidebarContent(),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            // 🔹 Panel izquierdo (seleccionados)
            SelectedFlavorsPanel(selectedFlavors: selectedFlavors),

            const SizedBox(width: 30),

            // 🔹 Lista scrolleable
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