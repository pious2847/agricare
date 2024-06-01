class Employee {
  int? id;
  String name;
  String contact;
  int? farmAssigned;

  Employee({
    this.id,
    required this.name,
    required this.contact,
    this.farmAssigned,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'farmAssigned': farmAssigned,
    };
  }
}