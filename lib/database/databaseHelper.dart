import 'package:agricare/models/admin.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/utils/requested.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:agricare/utils/admin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Private constructor
  DatabaseHelper._instance();

  // Static field for the singleton instance
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  final admincrud = UserCrud();
  final employeeCrud = EmployeeCrud();
  final supervisorcrud = SupervisorCrud();
  final farmCrud = FarmCrud();
  final machineryCrud = MachineryCrud();
  final supplies = SuppliesCrud();
  final requestedcrud = RequestedCrud();

  // Future<Database> get database async {
  //   _db ??= await _initDb();
  //   return _db!;
  // }
  // Future<Database> get database async {
  //   if (_db != null) return _db!;
  //   _db = await _initDb();
  //   return _db!;
  // }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'farm_management.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXIST admin(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    print('user table created');
    await db.execute('''
      CREATE TABLE IF NOT EXIST farm(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        location TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST machinery(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tagNumber TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST employee(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact TEXT NOT NULL,
        machineAssigned INTEGER,
        farmAssigned INTEGER,
        FOREIGN KEY (machineAssigned) REFERENCES machinery(id),
        FOREIGN KEY (farmAssigned) REFERENCES farm(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST supervisor(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact TEXT NOT NULL,
        farmsAssigned INTEGER,
        notes TEXT,
        FOREIGN KEY (farmsAssigned) REFERENCES farm(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST supplies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        stock INTEGER NOT NULL,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXIST requested(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        farmRequesting INTEGER,
        quantity INTEGER NOT NULL,
        approved INTEGER NOT NULL,
        FOREIGN KEY (farmRequesting) REFERENCES farm(id)
      )
    ''');
  }

// CRUD operations for User
  Future<int> addAdmin(Admin admin) async {
    Database db = await instance.initDb();
    return await db.insert('admin', admin.toMap());
  }

}
