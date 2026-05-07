import 'package:clemente_pos/core/widgets/admin_app_sidebar.dart';
import 'package:flutter/material.dart';

class AdminAppLayout extends StatelessWidget {
  final Widget sidebarContent;
  final Widget child;

  const AdminAppLayout({
    super.key,
    required this.sidebarContent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AdminAppSidebar(child: sidebarContent),
          Expanded(child: child),
        ],
      ),
    );
  }
}