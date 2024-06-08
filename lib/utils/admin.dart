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

Future<Admin?> getAdminById(int id) async {
  Database db = await _dbHelper.initDb();
  final admins = await db.query('admin', where: 'id = ?', whereArgs: [id]);

  if (admins.isNotEmpty) {
    final adminMap = admins.first;
    return Admin(
      id: adminMap['id'] as int,
      username: adminMap['username'] as String,
      password: adminMap['password'] as String,
    );
  }

  return null;
}

  Future<Admin?> getAdminByUsername(String username) async {
    Database db = await _dbHelper.initDb();
    final List<Map<String, dynamic>> maps = await db.query(
      'admin',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return Admin.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Admin>> getAdmin() async {
    Database db = await _dbHelper.initDb();
    var users = await db.query('admin');
    return users
        .map((admin) => Admin(
              id: admin['id'] as int,
              username: admin['username'] as String,
              password: admin['password'] as String,
            ))
        .toList();
  }

  Future<int> updateAdmin(Admin admin) async {
    Database db = await _dbHelper.initDb();
    return await db
        .update('admin', admin.toMap(), where: 'id = ?', whereArgs: [admin.id]);
  }

  Future<void> updateAdminPassword(int id, String newPassword) async {
    final databaseHelper = DatabaseHelper.instance;
    final admin = await getAdminById(id);

    if (admin != null) {
      final updatedAdmin = Admin(
        id: admin.id,
        username: admin.username,
        password: newPassword,
      );

      await databaseHelper.adminCrudInstance.updateAdmin(updatedAdmin);
    }
  }

  Future<int> deleteAdmin(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('admin', where: 'id = ?', whereArgs: [id]);
  }
}
