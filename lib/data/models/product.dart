class Product {
  final String id;
  final String nombre;
  final double precioVenta;
  final double costoProduccion;
  final bool iva;
  final bool ieps;
  final int cantidadBolas;
  final bool usaCuchara;
  final bool usaVaso;
  final bool usaCono;
  final bool usaCanasta;
  final bool usaPretzel;

  Product({
    required this.id,
    required this.nombre,
    required this.precioVenta,
    required this.costoProduccion,
    required this.iva,
    required this.ieps,
    required this.cantidadBolas,
    this.usaCuchara = false,
    this.usaVaso = false,
    this.usaCono = false,
    this.usaCanasta = false,
    this.usaPretzel = false,
  });

  /// Convierte el objeto Product a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precioVenta': precioVenta,
      'costoProduccion': costoProduccion,
      'iva': iva ? 1 : 0,
      'ieps': ieps ? 1 : 0,
      'cantidadBolas': cantidadBolas,
      'usaCuchara': usaCuchara ? 1 : 0,
      'usaVaso': usaVaso ? 1 : 0,
      'usaCono': usaCono ? 1 : 0,
      'usaCanasta': usaCanasta ? 1 : 0,
      'usaPretzel': usaPretzel ? 1 : 0,
    };
  }

  /// Crea un Product a partir de un Map<String, dynamic>
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'].toString(),
      nombre: map['nombre'] as String,
      precioVenta: (map['precioVenta'] as num).toDouble(),
      costoProduccion: (map['costoProduccion'] as num).toDouble(),
      iva: map['iva'] == 1,
      ieps: map['ieps'] == 1,
      cantidadBolas: map['cantidadBolas'] as int,
      usaCuchara: map['usaCuchara'] == 1,
      usaVaso: map['usaVaso'] == 1,
      usaCono: map['usaCono'] == 1,
      usaCanasta: map['usaCanasta'] == 1,
      usaPretzel: map['usaPretzel'] == 1,
    );
  }
}