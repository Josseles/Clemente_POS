import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool isManager; // nuevo parámetro

  const MenuButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.isManager = false, // por defecto false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primary,
        shape: const StadiumBorder(),
        minimumSize: Size(
          double.infinity,
          isManager ? 100 : 160, // btns extras mas compactos
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown, // ajusta el texto al espacio de forma escalable
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
