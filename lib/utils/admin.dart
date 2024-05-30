import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/admin.dart';
import 'package:sqflite/sqflite.dart';

class UserCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  
  Future<List<Admin>> getAdmin() async {
    Database db = await _dbHelper.initDb();
    var users = await db.query('admin');
    return users.map((admin) => Admin(
      id: admin['id'] as int,
      username: admin['username'] as String,
      password: admin['password'] as String,
    )).toList();
  }

  Future<int> updateAdmin(Admin admin) async {
    Database db = await _dbHelper.initDb();
    return await db.update('admin', admin.toMap(), where: 'id = ?', whereArgs: [admin.id]);
  }

  Future<int> deleteAdmin(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('admin', where: 'id = ?', whereArgs: [id]);
  }

}
