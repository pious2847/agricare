

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/daily_work_record.dart';
import 'package:sqflite/sqflite.dart';

class DailyCrud{
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
    
    Future<int> addDailyRecords(
    DailyWorkRecord dailyWorkRecord,
  ) async {
    Database db = await _dbHelper.initDb();
    return await db.insert('dailyrecords', dailyWorkRecord.toMap());
  }

    Future<List<DailyWorkRecord>> getDailyRecords() async {
    Database db = await _dbHelper.initDb();
    var dailyrecords = await db.query('dailyrecords');

    return dailyrecords.map((dailyrecord) => DailyWorkRecord(
        id: dailyrecord['id'] as int?,
        worktype: dailyrecord['worktype'] as String,
        employeeName : dailyrecord['employeeName'] as String,
        farm: dailyrecord['farm'] as String,
        suppliesUsed: dailyrecord['suppliesUsed'] as String,
        suppliesLeft: dailyrecord['suppliesLeft'] as String,
        dailyexpenses: dailyrecord['dailyexpenses'] as int,
        notes: dailyrecord['notes'] as String)).toList();
  }
    Future<int> updateDailyRecords(DailyWorkRecord dailyWorkRecord, ) async {
    Database db = await _dbHelper.initDb();
    return await db.update('dailyrecords', dailyWorkRecord.toMap(), where: 'id = ?', whereArgs: [dailyWorkRecord.id]);
  }
    Future<int> deleteDailyRecords(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('dailyrecords', where: 'id = ?', whereArgs: [id]);
  }

  
}