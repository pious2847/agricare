class DailyWorkRecord {
  int? id;
  late String worktype;
  late String employeeName;
  late String farm;
  late String suppliesUsed;
  late String suppliesLeft;
  // ignore: non_constant_identifier_names
  int dailyexpenses;
  String notes;

  DailyWorkRecord(
      {this.id,
      required this.worktype,
      required this.employeeName,
      required this.farm,
      required this.suppliesUsed,
      required this.suppliesLeft,
      // ignore: non_constant_identifier_names
      required this.dailyexpenses,
      required this.notes
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'worktype': worktype,
      'employeeName': employeeName,
      'farm': farm,
      'suppliesUsed': suppliesUsed,
      'suppliesLeft': suppliesLeft,
      'dailyexpenses':dailyexpenses,
      'notes': notes,
    };
  }
}
