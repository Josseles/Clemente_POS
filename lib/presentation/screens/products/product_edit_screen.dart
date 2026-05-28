import 'package:flutter/material.dart';

import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';

class EditProductScreen extends StatefulWidget {
  final Product producto;

  const EditProductScreen({
    super.key,
    required this.producto,
  });

  @override
  State<EditProductScreen> createState() =>
      _EditProductScreenState();
}

class _EditProductScreenState
    extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final ProductRepository _productRepository =
      ProductRepository();

  late TextEditingController _nombreController;

  late TextEditingController _precioController;

  late TextEditingController _costoController;

  late int _cantidadBolas;

  late bool iva;
  late bool ieps;

  late bool usaVasoCono;

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

  @override
  void initState() {
    super.initState();

    final producto = widget.producto;

    _nombreController = TextEditingController(
      text: producto.nombre,
    );

    _precioController = TextEditingController(
      text: producto.precioVenta.toString(),
    );

    _costoController = TextEditingController(
      text: producto.costoProduccion.toString(),
    );

    _cantidadBolas = producto.cantidadBolas;

    iva = producto.iva;
    ieps = producto.ieps;
    usaVasoCono = producto.usaVasoCono;

    precioSinImpuestos = _calcularPrecioSinImpuestos();
  }

  Future<void> actualizarProducto() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final productoActualizado = Product(
      id: widget.producto.id,
      nombre: _nombreController.text.trim(),
      precioVenta: double.parse(
        _precioController.text.trim(),
      ),
      costoProduccion: double.parse(
        _costoController.text.trim(),
      ),
      cantidadBolas: _cantidadBolas,
      iva: iva,
      ieps: ieps,
      usaVasoCono: usaVasoCono,
    );

    await _productRepository.actualizar(
      productoActualizado,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Producto actualizado correctamente',
        ),
      ),
    );

    Navigator.pop(context, true);
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
      controlAffinity:
          ListTileControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Producto',
        ),
      ),

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
                  if (value == null ||
                      value.trim().isEmpty) {
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

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Ingresa un precio';
                  }

                  if (double.tryParse(value) ==
                      null) {
                    return 'Precio inválido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              const Text(
                'Impuestos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                    precioSinImpuestos = _calcularPrecioSinImpuestos();
                  });
                },
              ),

              const SizedBox(height: 30),

              const Text(
                'Personalización',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              buildCheckbox(
                titulo: 'Usa cuchara',
                valor: usaCuchara,
                onChanged: (value) {
                  setState(() {
                    usaCuchara =
                        value ?? false;
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
                    usaCanasta =
                        value ?? false;
                  });
                },
              ),

              buildCheckbox(
                titulo: 'Usa pretzel',
                valor: usaPretzel,
                onChanged: (value) {
                  setState(() {
                    usaPretzel =
                        value ?? false;
                  });
                },
              ),
              */

              const SizedBox(height: 40),

              SizedBox(
                height: 50,

                child: ElevatedButton(
                  onPressed: actualizarProducto,

                  child: const Text(
                    'Actualizar Producto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}