class InventoryItem {
  final int? id;
  final String name;
  final int stock;
  final double cost;

  InventoryItem({
    this.id,
    required this.name,
    required this.stock,
    required this.cost,
  });

  /// Convertir objeto a Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': name,
      'stock': stock,
      'costo': cost,
    };
  }

  /// Crear objeto desde un Map de SQLite
  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      id: map['id'] as int?,
      name: map['nombre'] as String,
      stock: map['stock'] as int,
      cost: (map['costo'] as num).toDouble(),
    );
  }
}