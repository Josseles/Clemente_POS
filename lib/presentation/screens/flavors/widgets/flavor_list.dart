import 'package:flutter/material.dart';

class FlavorList extends StatelessWidget {
  final List<Map<String, dynamic>> flavors;
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
      ),
      child: ListView.builder(
        itemCount: flavors.length,
        itemBuilder: (context, index) {
          final flavor = flavors[index];

          return CheckboxListTile(
            title: Text(flavor["name"]),
            value: flavor["selected"],
            onChanged: (_) => onToggle(index),
          );
        },
      ),
    );
  }
}