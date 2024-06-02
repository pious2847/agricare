import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/supplies.dart';
import 'package:sqflite/sqflite.dart';

class SuppliesCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;



  Future<int> addSupplies(Supplies supplies) async {
    Database db = await _dbHelper.initDb();
    return await db.insert('supplies', supplies.toMap());
  }

  Future<List<Supplies>> getSupplies() async {
    Database db = await _dbHelper.initDb();
    var suppliesList = await db.query('supplies');
    return suppliesList
        .map((supplies) => Supplies(
              id: supplies['id'] as int,
              product: supplies['product'] as String,
              stock: supplies['stock'] as int,
              description: supplies['description'] as String,
            ))
        .toList();
  }

  Future<List<Supplies>> getLowStock() async {
    Database db = await _dbHelper.initDb();
    var lowsupplies = await db.query('supplies', where: 'stock <= 10', );
     return lowsupplies
        .map((supplies) => Supplies(
              id: supplies['id'] as int,
              product: supplies['product'] as String,
              stock: supplies['stock'] as int,
              description: supplies['description'] as String,
            ))
        .toList();
    
  }

  Future<int> updateSupplies(Supplies supplies) async {
    Database db = await _dbHelper.initDb();
    return await db.update('supplies', supplies.toMap(),
        where: 'id = ?', whereArgs: [supplies.id]);
  }

  Future<int> deleteSupplies(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('supplies', where: 'id = ?', whereArgs: [id]);
  }
}
