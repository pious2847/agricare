class Farm {
  int? id;
  late String name;
  late String location;
  late String farmproduce;

  Farm({this.id, required this.name, required this.location, required this.farmproduce,} );

 Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'location': location,
    'farmproduce': farmproduce,
  };
}
}
