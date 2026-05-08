import 'package:flutter/material.dart';

class InventorySearch extends StatelessWidget {
  const InventorySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,

      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar producto",

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}