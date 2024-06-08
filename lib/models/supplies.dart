class Supplies {
  int? id;
  late String product;
  late int stock;
  late String description;

  Supplies({this.id, required this.product, required this.stock,  required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'stock': stock,
      'description': description
    };
  }
     // Add this factory method
  factory Supplies.fromMap(Map<String, dynamic> map) {
    return Supplies(
      id: map['id'],
      product: map['product'],
      stock: map['stock'],
      description: map['description'],
    );
  }
}
