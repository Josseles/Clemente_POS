import 'package:flutter/material.dart';

import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final ProductRepository _productRepository = ProductRepository();

  final TextEditingController _idController = TextEditingController();

  final TextEditingController _nombreController = TextEditingController();

  final TextEditingController _precioController = TextEditingController();

  final TextEditingController _costoController = TextEditingController();

  int _cantidadBolas = 1;

  bool iva = false;
  bool ieps = false;

  bool usaVasoCono = false;
  /*
  bool usaCuchara = false;
  bool usaVaso = false;
  bool usaCono = false;
  bool usaCanasta = false;
  bool usaPretzel = false;
  */

  Future<void> guardarProducto() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final producto = Product(
      id: _idController.text.trim(),
      nombre: _nombreController.text.trim(),
      precioVenta: double.parse(_precioController.text.trim()),
      costoProduccion: double.parse(_costoController.text.trim()),
      cantidadBolas: _cantidadBolas,
      iva: iva,
      ieps: ieps,
      usaVasoCono: usaVasoCono,
      /*
      usaCuchara: usaCuchara,
      usaVaso: usaVaso,
      usaCono: usaCono,
      usaCanasta: usaCanasta,
      usaPretzel: usaPretzel,
      */
    );

    await _productRepository.insertar(producto);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado correctamente')),
    );

    Navigator.pop(context);
  }

  Widget buildCheckbox({
    required String titulo,
    required bool valor,
    required Function(bool?) onChanged,
  }) {
    return CheckboxListTile(
      title: Text(titulo),
      value: valor,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Producto')),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              // ID
              TextFormField(
                controller: _idController,

                decoration: const InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un ID';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Nombre
              TextFormField(
                controller: _nombreController,

                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un nombre';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Precio
              TextFormField(
                controller: _precioController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Precio de Venta',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa un precio';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Precio inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _costoController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Costo de producción',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingresa el costo';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Costo inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              const Text(
                'Cantidad de bolas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<int>(
                value: _cantidadBolas,

                decoration: const InputDecoration(border: OutlineInputBorder()),

                items: [1, 2, 3, 4]
                    .map(
                      (cantidad) => DropdownMenuItem(
                        value: cantidad,
                        child: Text('$cantidad bolas'),
                      ),
                    )
                    .toList(),

                onChanged: (value) {
                  setState(() {
                    _cantidadBolas = value ?? 1;
                  });
                },
              ),

              const SizedBox(height: 30),

              const Text(
                'Impuestos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              buildCheckbox(
                titulo: 'IVA',
                valor: iva,
                onChanged: (value) {
                  setState(() {
                    iva = value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'IEPS',
                valor: ieps,
                onChanged: (value) {
                  setState(() {
                    ieps = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 30),

              const Text(
                'Personalización',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              buildCheckbox(
                titulo: '¿Usa vaso o cono?',
                valor: usaVasoCono,
                onChanged: (value) {
                  setState(() {
                    usaVasoCono = value ?? false;
                  });
                },
              ),

              /*
              const SizedBox(height: 30),

              const Text(
                'Consumibles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              buildCheckbox(
                titulo: 'Usa cuchara',
                valor: usaCuchara,
                onChanged: (value) {
                  setState(() {
                    usaCuchara = value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'Usa vaso',
                valor: usaVaso,
                onChanged: (value) {
                  setState(() {
                    usaVaso = value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'Usa cono',
                valor: usaCono,
                onChanged: (value) {
                  setState(() {
                    usaCono = value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'Usa canasta',
                valor: usaCanasta,
                onChanged: (value) {
                  setState(() {
                    usaCanasta = value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'Usa pretzel',
                valor: usaPretzel,
                onChanged: (value) {
                  setState(() {
                    usaPretzel = value ?? false;
                  });
                },
              ),
              */
              
              const SizedBox(height: 40),

              SizedBox(
                height: 50,

                child: ElevatedButton(
                  onPressed: guardarProducto,

                  child: const Text('Guardar Producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
