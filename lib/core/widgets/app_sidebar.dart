import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppSidebar extends StatelessWidget {
  final Widget child;

  const AppSidebar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: child,
    );
  }
}