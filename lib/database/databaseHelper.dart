import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'farm_management.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE farm(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        location TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE machinery(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        tagNumber TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE employee(
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
      CREATE TABLE supervisor(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact TEXT NOT NULL,
        farmsAssigned INTEGER,
        notes TEXT,
        FOREIGN KEY (farmsAssigned) REFERENCES farm(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE supplies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        stock INTEGER NOT NULL,
        description TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE requested(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product TEXT NOT NULL,
        farmRequesting INTEGER,
        quantity INTEGER NOT NULL,
        approved INTEGER NOT NULL,
        FOREIGN KEY (farmRequesting) REFERENCES farm(id)
      )
    ''');
  }
}
