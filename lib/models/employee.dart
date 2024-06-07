class Employee {
  int? id;
  String name;
  String contact;
  String? farmAssigned;
  String machineryAssigned;

  Employee({
    this.id,
    required this.name,
    required this.contact,
    required this.farmAssigned,
    required this.machineryAssigned
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'farmAssigned': farmAssigned,
      'machineryAssigned': machineryAssigned
    };
  }
}
