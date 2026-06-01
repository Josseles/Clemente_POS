import 'package:flutter/material.dart';

import '../../../../data/models/flavor.dart';

class FlavorInventorySidebar extends StatelessWidget {
  final CategoriaSabor? categoriaFiltro;

  final bool? activoFiltro;

  final ValueChanged<CategoriaSabor?> onCategoriaChanged;

  final ValueChanged<bool?> onActivoChanged;

  const FlavorInventorySidebar({
    super.key,
    required this.categoriaFiltro,
    required this.activoFiltro,
    required this.onCategoriaChanged,
    required this.onActivoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        const Text(
          "Categoría",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<CategoriaSabor?>(
            value: categoriaFiltro,

            items: const [
              DropdownMenuItem(value: null, child: Text("Todas")),
              DropdownMenuItem(value: CategoriaSabor.agua, child: Text("Agua")),
              DropdownMenuItem(
                value: CategoriaSabor.crema,
                child: Text("Crema"),
              ),
            ],

            onChanged: onCategoriaChanged,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          "Estado",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonFormField<bool?>(
            value: activoFiltro,

            items: const [
              DropdownMenuItem(value: null, child: Text("Todos")),
              DropdownMenuItem(value: true, child: Text("Activos")),
              DropdownMenuItem(value: false, child: Text("Inactivos")),
            ],

            onChanged: onActivoChanged,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12),
              ),
            ),
          ),
        ),

        const Spacer(),

        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text("Regresar"),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
