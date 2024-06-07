class Requested {
  int? id;
  String product;
  String farmRequesting;
  int quantity;

  Requested({this.id, required this.product, required this.farmRequesting, required this.quantity,});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
      'farmRequesting': farmRequesting,
    };
  }
}
