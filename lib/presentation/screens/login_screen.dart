import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../widgets/logo_panel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          // Formulario
          Expanded(
            flex: 2,
            child: LoginForm(),
          ),

          // Panel derecho (logo)
          Expanded(
            flex: 1,
            child: LogoPanel(),
          ),
        ],
      ),
    );
  }
}