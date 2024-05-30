class Supervisor {
  int? id;
  String name;
  String contact;
  int? farmsAssigned;
  String notes;

  Supervisor({this.id, required this.name, required this.contact, this.farmsAssigned, required this.notes});

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
