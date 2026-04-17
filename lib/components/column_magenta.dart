import 'package:flutter/material.dart';

class ColumnaMagenta extends StatelessWidget {
  const ColumnaMagenta({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: const Color.fromARGB(255, 200, 0, 153),
      child: Column(
        children: [
          Text("Column Magenta"),
        ],
      ),
    );
  }
}