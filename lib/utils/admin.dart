import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/admin.dart';
import 'package:sqflite/sqflite.dart';

class UserCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;


    // CRUD operations for User
  Future<int> addAdmin(Admin admin) async {
    Database db = await _dbHelper.initDb();
      print('Admin Data saved ${admin.toMap()}');
    return await db.insert('admin', admin.toMap());
  }
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
