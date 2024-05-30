class DailyWorkRecord {
  int? id;
  late String work;
  late String employeeName;
  late String farm;
  late String suppliesUsed;
  late String suppliesLeft;

  DailyWorkRecord(this.id, this.work, this.employeeName,this.farm, this.suppliesUsed, this.suppliesLeft );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'work': work,
      'employeeName': employeeName,
      'farm': farm,
      'suppliesUsed': suppliesUsed,
      'suppliesLeft':suppliesLeft
    };
  }
}
