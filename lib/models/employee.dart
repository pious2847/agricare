class Employee {
  int? id;
  String name;
  String contact;
  int? machineAssigned;
  int? farmAssigned;

  Employee({this.id, required this.name, required this.contact, this.machineAssigned, this.farmAssigned});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'machineAssigned': machineAssigned,
      'farmAssigned': farmAssigned,
    };
  }
}
