import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Import your other dependencies
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/utils/requested.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:agricare/utils/admin.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  late final UserCrud admincrud;
  late final EmployeeCrud employeeCrud;
  late final SupervisorCrud supervisorcrud;
  late final FarmCrud farmCrud;
  late final MachineryCrud machineryCrud;
  late final SuppliesCrud supplies;
  late final RequestedCrud requestedcrud;

  Future<Database> get database async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    // Initialize the database factory for sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    String path = join(await getDatabasesPath(), 'farm_management.db');
    return await openDatabase(path, version: 1, onCreate: _createDb, singleInstance: true);
  }

  UserCrud get adminCrudInstance {
    admincrud = UserCrud(this);
    return admincrud;
  }

  EmployeeCrud get employeeCrudInstance {
    employeeCrud = EmployeeCrud(this);
    return employeeCrud;
  }

  SupervisorCrud get supervisorCrudInstance {
    supervisorcrud = SupervisorCrud(this);
    return supervisorcrud;
  }

  FarmCrud get farmCrudInstance {
    farmCrud = FarmCrud();
    return farmCrud;
  }

  MachineryCrud get machineryCrudInstance {
    machineryCrud = MachineryCrud(this);
    return machineryCrud;
  }

  SuppliesCrud get suppliesCrudInstance {
    supplies = SuppliesCrud(this);
    return supplies;
  }

  RequestedCrud get requestedCrudInstance {
    requestedcrud = RequestedCrud(this);
    return requestedcrud;
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
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "name" TEXT NOT NULL,
        "location" TEXT NOT NULL
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
}
