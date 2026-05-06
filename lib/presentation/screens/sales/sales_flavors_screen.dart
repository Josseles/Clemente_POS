import 'package:flutter/material.dart';
import '../../../core/widgets/app_layout.dart';
import 'widgets/sales_sidebar.dart';

class SalesFlavorsScreen extends StatefulWidget {
  const SalesFlavorsScreen({super.key});

  @override
  State<SalesFlavorsScreen> createState() =>
      _SalesFlavorsScreenState();
}

class _SalesFlavorsScreenState extends State<SalesFlavorsScreen> {
  List<String> selected = [];

  final List<String> flavors = [
    "Vainilla",
    "Chocolate",
    "Fresa",
    "Oreo",
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sidebarContent: SalesSidebar(
        selectedProducts: selected,
        onConfirm: () {},
        onBack: () => Navigator.pop(context),
      ),
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: flavors.map((flavor) {
          final isSelected = selected.contains(flavor);

          return CheckboxListTile(
            title: Text(flavor),
            value: isSelected,
            onChanged: (_) {
              setState(() {
                if (isSelected) {
                  selected.remove(flavor);
                } else {
                  selected.add(flavor);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }
}