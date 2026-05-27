import 'package:flutter/material.dart';

class LogoPanel extends StatelessWidget {
  const LogoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE32E8F),
      child: Center(
        child: Image.asset("assets/images/logo.png", width: 200, height: 200),
      ),
    );
  }
}
