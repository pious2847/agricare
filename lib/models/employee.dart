class Employee {
  int? id;
  String name;
  String contact;
  final List<int> machineAssigned; // This should be a list
  int? farmAssigned;

  Employee({this.id, required this.name, required this.contact, required this.machineAssigned, this.farmAssigned});

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
