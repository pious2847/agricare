import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/machinery.dart';
import 'package:sqflite/sqflite.dart';

class MachineryCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addMachinery(Machinery machinery) async {
    Database db = await _dbHelper.initDb();
    return await db.insert('machinery', machinery.toMap());
  }

  Future<List<Machinery>> getMachinery() async {
    Database db = await _dbHelper.initDb();
    var machineryList = await db.query('machinery');
    return machineryList.map((machinery) => Machinery(
      id: machinery['id'] as int,
      name: machinery['name'] as String,
      tagNumber: machinery['tagNumber'] as String,
    )).toList();
  }

  Future<int> updateMachinery(Machinery machinery) async {
    Database db = await _dbHelper.initDb();
    return await db.update('machinery', machinery.toMap(), where: 'id = ?', whereArgs: [machinery.id]);
  }

  Future<int> deleteMachinery(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('machinery', where: 'id = ?', whereArgs: [id]);
  }
}
