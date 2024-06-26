class Requested {
  int? id;
  String product;
  String farmRequesting;
  int quantity;
  int approved;

  Requested({this.id, required this.product, required this.farmRequesting, required this.quantity, required this.approved});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
      'farmRequesting': farmRequesting,
      'approved':approved,
    };
  }
}
