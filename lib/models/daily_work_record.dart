class DailyWorkRecord {
  int? id;
  late String work;
  late String employeeName;
  late String farm;
  late String suppliesUsed;
  late String suppliesLeft;
  // ignore: non_constant_identifier_names
  int ExpensesTotal;

  DailyWorkRecord(
      {this.id,
      required this.work,
      required this.employeeName,
      required this.farm,
      required this.suppliesUsed,
      required this.suppliesLeft,
      // ignore: non_constant_identifier_names
      required this.ExpensesTotal});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'work': work,
      'employeeName': employeeName,
      'farm': farm,
      'suppliesUsed': suppliesUsed,
      'suppliesLeft': suppliesLeft
    };
  }
}
