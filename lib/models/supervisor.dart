class Supervisor {
  int? id;
  String name;
  String contact;
  String? farmsAssigned;
  String notes;

  Supervisor({this.id, required this.name, required this.contact, required this.farmsAssigned, required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'farmsAssigned': farmsAssigned,
      'notes': notes,
    };
  }
}
