import 'package:agricare/utils/daily_work_records.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
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


  late final AdminCrud admincrud = AdminCrud();
  late final EmployeeCrud employeeCrud = EmployeeCrud();
  late final SupervisorCrud supervisorcrud = SupervisorCrud(this);
  late final FarmCrud farmCrud = FarmCrud();
  late final MachineryCrud machineryCrud = MachineryCrud();
  late final SuppliesCrud supplies = SuppliesCrud();
  late final RequestedCrud requestedcrud = RequestedCrud(this);
  late final DailyCrud dailycrud = DailyCrud();

  Future<Database> get database async {
    _db ??= await initDb();
    return _db!;
  }

Future<Database> initDb() async {
  // Initialize the database factory for sqflite_common_ffi
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi; // Initialize the databaseFactory

  String path = join(await getDatabasesPath(), 'farm_management.db');
  return await databaseFactoryFfi.openDatabase(
    path,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: _createDb,
    ),
  );
}

  AdminCrud get adminCrudInstance {
    return admincrud;
  }

  EmployeeCrud get employeeCrudInstance {
    return employeeCrud;
  }

  SupervisorCrud get supervisorCrudInstance {
    return supervisorcrud;
  }

  FarmCrud get farmCrudInstance {
    return farmCrud;
  }

  MachineryCrud get machineryCrudInstance {
    return machineryCrud;
  }

  SuppliesCrud get suppliesCrudInstance {
    return supplies;
  }

  RequestedCrud get requestedCrudInstance {
    return requestedcrud;
  }

  DailyCrud get dailyCrudInstance {
    return dailycrud;
  }


  void _createDb(Database db, int version) async {

    await db.execute('''
    CREATE TABLE IF NOT EXISTS admin(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      password TEXT NOT NULL
    )
  ''');


    print('user table created');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS farm(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      location TEXT NOT NULL,
      farmproduce TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS machinery(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      tagNumber TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS employee(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      contact TEXT NOT NULL,
      farmAssigned TEXT NOT NULL,
      machineryAssigned TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS supervisor(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      contact TEXT NOT NULL,
      farmsAssigned TEXT NOT NULL,
      notes TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS supplies(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      product TEXT NOT NULL,
      stock INTEGER NOT NULL,
      description TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS requested(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      product TEXT NOT NULL,
      farmRequesting TEXT NOT NULL,
      quantity INTEGER NOT NULL,
      approved INTEGER NOT NULL
    )
  ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS dailyrecords (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        worktype TEXT NOT NULL,
        employeeName TEXT NOT NULL,
        farm TEXT NOT NULL,
        suppliesUsed TEXT NOT NULL,
        suppliesLeft TEXT NOT NULL,
        dailyexpenses INTEGER NOT NULL,
        notes TEXT NOT NULL
      )
    ''');

  }
}
