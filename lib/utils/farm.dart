import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:sqflite/sqflite.dart';

class FarmCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> getTotalFarms() async {
  Database db = await _dbHelper.initDb();
  List<Map<String, Object?>> result = await db.query('farm');
  return result.length;
}

  Future<int> addFarm(Farm farm) async {
    final db = await _dbHelper.database;
    return await db.insert('farm', farm.toMap());
  }

  Future<List<Farm>> getFarms() async {
    final db = await _dbHelper.database;
    var farms = await db.query('farm');
    return farms.map((farm) => Farm(
      id: farm['id'] as int?,
      name: farm['name'] as String,
      location: farm['location'] as String,
      farmproduce: farm['farmproduce'] as String,
    )).toList();

  }

Future<List<Farm>> getFarmById(int id) async {
  final db = await _dbHelper.database;
  try {
    var farms = await db.query('farm', where: 'id = ?', whereArgs: [id]);
    if (farms.isNotEmpty) {
      return farms.map((farm) => Farm(
        id: farm['id'] as int?,
        name: farm['name'] as String,
        location: farm['location'] as String,
        farmproduce: farm['farmproduce'] as String,
      )).toList();
    } else {
      return []; // No farms found with the given ID
    }
  } catch (e) {
    print('Error fetching farm by ID: $e');
    return []; // Return an empty list in case of an error
  }
}

Future<String> getFarmName(int? farmAssigned) async {
  if (farmAssigned == null) {
    return ''; // or any default value you prefer
  }
  List<Farm> farms = await getFarmById(farmAssigned);
  if (farms.isNotEmpty) {
    return farms.first.name;
  } else {
    return ''; // or any default value you prefer
  }
}



  Future<int> updateFarm(Farm farm) async {
    final db = await _dbHelper.database;
    return await db.update('farm', farm.toMap(), where: 'id = ?', whereArgs: [farm.id]);
  }

  Future<int> deleteFarm(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('farm', where: 'id = ?', whereArgs: [id]);
  }
}