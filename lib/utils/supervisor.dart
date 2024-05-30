import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:sqflite/sqflite.dart';

class SupervisorCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addSupervisor(Supervisor supervisor) async {
    Database db = await _dbHelper.initDb();
    return await db.insert('supervisor', supervisor.toMap());
  }

  Future<List<Supervisor>> getSupervisors() async {
    Database db = await _dbHelper.initDb();
    var supervisors = await db.query('supervisor');
    return supervisors.map((supervisor) => Supervisor(
      id: supervisor['id'] as int,
      name: supervisor['name'] as String,
      contact: supervisor['contact'] as String,
      farmsAssigned: supervisor['farmsAssigned'] as int,
      notes: supervisor['notes'] as String, 
    )).toList();
  }

  Future<int> updateSupervisor(Supervisor supervisor) async {
    Database db = await _dbHelper.initDb();
    return await db.update('supervisor', supervisor.toMap(), where: 'id = ?', whereArgs: [supervisor.id]);
  }

  Future<int> deleteSupervisor(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('supervisor', where: 'id = ?', whereArgs: [id]);
  }
}
