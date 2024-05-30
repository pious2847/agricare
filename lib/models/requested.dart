class Requested {
  int? id;
  String product;
  int? farmRequesting;
  int quantity;
  int approved;

  Requested({this.id, required this.product, this.farmRequesting, required this.quantity, required this.approved});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'farmRequesting': farmRequesting,
      'quantity': quantity,
      'approved': approved,
    };
  }
}
