import 'package:flutter/material.dart';

class CountedCashInput
    extends StatelessWidget {

  final TextEditingController
  controller;

  const CountedCashInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      keyboardType:
          TextInputType.number,

      decoration:
          const InputDecoration(
            labelText:
                'Efectivo contado',

            border:
                OutlineInputBorder(),
          ),
    );
  }
}