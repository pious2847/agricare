import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:sqflite/sqflite.dart';

class FarmCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addFarm(Farm farm) async {
    Database db = await _dbHelper.database;
    return await db.insert('farm', farm.toMap());
  }

  Future<List<Farm>> getFarms() async {
    Database db = await _dbHelper.database;
    var farms = await db.query('farm');
    return farms.map((farm) => Farm(
      id: farm['id'] as int,
      name: farm['name'] as String,
      location: farm['location'] as String, 
      farmproduce: farm['farmproduce'] as String,
    )).toList();
  }

  Future<int> updateFarm(Farm farm) async {
    Database db = await _dbHelper.database;
    return await db.update('farm', farm.toMap(), where: 'id = ?', whereArgs: [farm.id]);
  }

  Future<int> deleteFarm(int id) async {
    Database db = await _dbHelper.database;
    return await db.delete('farm', where: 'id = ?', whereArgs: [id]);
  }
}
