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

  Future<int> getTotalSupplies() async {
  Database db = await _dbHelper.initDb();
  List<Map<String, Object?>> result = await db.query('supplies');
  if(result.isEmpty){
    return 0;
  }else{
    return result.length;
  }

  
}
 
  Future<List<Supplies>> getLowStock() async {
    // Initialize the database
    Database db = await _dbHelper.initDb();
    // Query for supplies where stock is less than or equal to 10
    try {
      var lowsupplies =
          await db.query('supplies', where: 'stock <= ?', whereArgs: [10]);
      // Map the query results to a list of Supplies objects
      return lowsupplies
          .map((supplies) => Supplies(
                id: supplies['id'] as int,
                product: supplies['product'] as String,
                stock: supplies['stock'] as int,
                description: supplies['description'] as String,
              ))
          .toList();
    } catch (e) {
      // Handle any errors that occur during the query
      print('Error querying low stock supplies: $e');
      return [];
    }
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
