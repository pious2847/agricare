import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/requested.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:sqflite/sqflite.dart';

class RequestedCrud {
  // final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  late final SuppliesCrud _suppliesCrud =
      DatabaseHelper.instance.suppliesCrudInstance;

  final DatabaseHelper _dbHelper;
  RequestedCrud(this._dbHelper);

  Future<int> addRequested(Requested requested, String selectedSupply) async {
    Database db = await _dbHelper.initDb();
    final supply = await _suppliesCrud.getSuppliesByname(selectedSupply);
    final remainingstock = supply!.stock - requested.quantity;
    
    if (supply == null) {
        // If the supply is not found, rollback the transaction
        return Future.error('Supply not found');
      }

      final remainingStock = supply.stock - requested.quantity;

      if (remainingStock < 0) {
        // If there's not enough stock, rollback the transaction
        return Future.error('Insufficient stock');
      }
    final updatesupplies = Supplies(
        id: supply.id,
        product: supply.product,
        stock: remainingstock,
        description: supply.description);
     await _suppliesCrud.updateSupplies(updatesupplies);
     
    return await db.insert('requested', requested.toMap());
  }

  Future<List<Requested>> getRequested() async {
    Database db = await _dbHelper.initDb();
    var requestedList = await db.query('requested');
    return requestedList
        .map((requested) => Requested(
              id: requested['id'] as int,
              product: requested['product'] as String,
              quantity: requested['quantity'] as int,
              farmRequesting: requested['farmRequesting'] as String,
            ))
        .toList();
  }

  Future<int> updateRequested(Requested requested) async {
    Database db = await _dbHelper.initDb();
    return await db.update('requested', requested.toMap(),
        where: 'id = ?', whereArgs: [requested.id]);
  }

  Future<int> deleteRequested(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('requested', where: 'id = ?', whereArgs: [id]);
  }
}
