import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AdminAppSidebar extends StatelessWidget {
  final Widget child;

  const AdminAppSidebar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.azul,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: child,
    );
  }
}