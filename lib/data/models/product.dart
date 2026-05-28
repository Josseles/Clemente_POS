class Product {
  final String id;
  final String nombre;
  final double precioVenta;
  final double costoProduccion;
  final bool iva;
  final bool ieps;
  final int cantidadBolas;
  final bool usaVasoCono;

  Product({
    required this.id,
    required this.nombre,
    required this.precioVenta,
    required this.costoProduccion,
    required this.iva,
    required this.ieps,
    required this.cantidadBolas,
    this.usaVasoCono = false,
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
      'usaVasoCono': usaVasoCono ? 1 : 0,
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
      usaVasoCono: map['usaVasoCono'] == 1,
    );
  }
}