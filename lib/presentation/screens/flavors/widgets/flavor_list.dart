import 'package:flutter/material.dart';
import '../../../../data/models/flavor.dart';

class FlavorList extends StatelessWidget {
  final List<Flavor> flavors;
  final Function(int) onToggle;

  const FlavorList({
    super.key,
    required this.flavors,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        itemCount: flavors.length,
        itemBuilder: (context, index) {
          final flavor = flavors[index];

          return CheckboxListTile(
            title: Text(
              flavor.nombre,
              style: const TextStyle(fontSize: 16),
            ),
            value: flavor.activo,
            onChanged: (_) => onToggle(index),
            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }
}