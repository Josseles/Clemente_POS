import 'package:clemente_pos/core/widgets/app_sidebar.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget sidebarContent;
  final Widget child;

  const AppLayout({
    super.key,
    required this.sidebarContent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppSidebar(child: sidebarContent),
          Expanded(child: child),
        ],
      ),
    );
  }
}