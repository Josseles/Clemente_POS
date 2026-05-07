import 'package:flutter/material.dart';

// Core
import '../../../core/widgets/admin_layout.dart';

// Widgets
import 'widgets/flavor_register_sidebar.dart';

class FlavorRegisterScreen extends StatelessWidget {
  const FlavorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminAppLayout(
      sidebarContent: const FlavorRegisterSidebar(),

      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          children: [
            // 🔹 Título
            const Text(
              "Registro de sabores",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // 🔹 Panel principal
            Expanded(
              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(30),

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Sabor
                    const Text(
                      "Sabor",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    buildTextField(),

                    const SizedBox(height: 40),

                    // 🔹 Tipo de sabor
                    const Text(
                      "Tipo de sabor",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    buildTextField(),
                    const SizedBox(height: 40),

                    SizedBox(
                      width: 140,

                      child: ElevatedButton(
                        onPressed: () {},
  
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: const StadiumBorder(),
                          minimumSize: const Size(140, 50),
                          alignment: Alignment.center,
                        ),

                        child: const Text("Aceptar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 TextField reutilizable
  Widget buildTextField() {
    return SizedBox(
      width: 400,

      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
