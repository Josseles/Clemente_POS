/*
class InventoryItem {
  final int? id;
  final String nombre;
  final int stock;
  final int stockMinimo;
  final double costo;

  InventoryItem({
    this.id,
    required this.nombre,
    required this.stock,
    required this.stockMinimo,
    required this.costo,
  });

  /// Convierte el objeto InventoryItem a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'stock': stock,
      'stockMinimo': stockMinimo,
      'costo': costo,
    };
  }

  /// Crea un InventoryItem a partir de un Map<String, dynamic>
  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      stock: map['stock'] as int,
      stockMinimo: map['stockMinimo'] as int,
      costo: (map['costo'] as num).toDouble(),
    );
  }
}
*/