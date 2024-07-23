class InventoryItem {
  String id;
  String name;
  int quantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }

  static InventoryItem fromMap(String id, Map<String, dynamic> map) {
    return InventoryItem(
      id: id,
      name: map['name'],
      quantity: map['quantity'],
    );
  }
}
