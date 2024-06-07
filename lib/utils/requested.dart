import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/requested.dart';
import 'package:sqflite/sqflite.dart';

class RequestedCrud {
  // final DatabaseHelper _dbHelper = DatabaseHelper.instance;

      final DatabaseHelper _dbHelper;
    RequestedCrud(this._dbHelper);
  
  Future<int> addRequested(Requested requested) async {
    Database db = await _dbHelper.initDb();

    return await db.insert('requested', requested.toMap());
  }

  Future<List<Requested>> getRequested() async {
    Database db = await _dbHelper.initDb();
    var requestedList = await db.query('requested');
    return requestedList.map((requested) => Requested(
      id: requested['id'] as int,
      product: requested['product'] as String,
      quantity: requested['quantity'] as int,
      farmRequesting: requested['farmRequesting'] as String,
    )).toList();
  }

  Future<int> updateRequested(Requested requested) async {
    Database db = await _dbHelper.initDb();
    return await db.update('requested', requested.toMap(), where: 'id = ?', whereArgs: [requested.id]);
  }

  Future<int> deleteRequested(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('requested', where: 'id = ?', whereArgs: [id]);
  }
}
