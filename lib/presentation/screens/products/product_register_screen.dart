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

  final TextEditingController _nombreController = TextEditingController();

  final TextEditingController _precioController = TextEditingController();

  final TextEditingController _costoController = TextEditingController();

  int _cantidadBolas = 1;

  bool iva = false;
  bool ieps = false;

  bool usaVasoCono = false;

  double precioSinImpuestos = 0;

  static const double ivaImpuesto = 0.16;
  static const double iepsImpuesto = 0.08;

  double _calcularPrecioSinImpuestos() {
    final precio = double.tryParse(_precioController.text) ?? 0;

    double factor = 1.0;

    if (ieps) {
      factor *= (1 + iepsImpuesto);
    }

    if (iva) {
      factor *= (1 + ivaImpuesto);
    }

    return precio / factor;
  }

  Future<void> guardarProducto() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final producto = Product(
      id: null,

      nombre: _nombreController.text.trim(),

      precioVenta: double.parse(_precioController.text.trim()),

      costoProduccion: double.parse(_costoController.text.trim()),

      cantidadBolas: _cantidadBolas,

      iva: iva,
      ieps: ieps,

      usaVasoCono: usaVasoCono,
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

                onChanged: (_) {
                  setState(() {
                    precioSinImpuestos = _calcularPrecioSinImpuestos();
                  });
                },

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

              // Costo producción
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
                initialValue: _cantidadBolas,

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

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Precio sin impuestos: '
                  '\$${precioSinImpuestos.toStringAsFixed(2)}',

                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),

              buildCheckbox(
                titulo: 'IVA',

                valor: iva,

                onChanged: (value) {
                  setState(() {
                    iva = value ?? false;
                  });

                  setState(() {
                    precioSinImpuestos = _calcularPrecioSinImpuestos();
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

                  setState(() {
                    precioSinImpuestos = _calcularPrecioSinImpuestos();
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
