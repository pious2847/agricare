class Machinery {
  int? id;
  late String name;
  late String tagNumber;

  Machinery({this.id, required this.name, required this.tagNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagNumber': tagNumber,
    };
  }
}
