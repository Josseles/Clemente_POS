import 'package:flutter/material.dart';

class CloseCashButton
    extends StatelessWidget {

  final VoidCallback onPressed;

  const CloseCashButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton(
        onPressed: onPressed,

        child: const Text(
          'Cerrar sesión',
        ),
      ),
    );
  }
}