import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> addEmployee(Employee employee) async {
    Database db = await _dbHelper.database;
    return await db.insert('employee', employee.toMap());
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await _dbHelper.database;
    var employees = await db.query('employee');
    return employees.map((employee) => Employee(
      id: employee['id'] as int,
      name: employee['name'] as String,
      contact: employee['contact'] as String,
      machineAssigned: employee['machineAssigned'] as List<int>,
      farmAssigned: employee['farmAssigned'] as int,
    )).toList();
  }

  Future<int> updateEmployee(Employee employee) async {
    Database db = await _dbHelper.database;
    return await db.update('employee', employee.toMap(), where: 'id = ?', whereArgs: [employee.id]);
  }

  Future<int> deleteEmployee(int id) async {
    Database db = await _dbHelper.database;
    return await db.delete('employee', where: 'id = ?', whereArgs: [id]);
  }
}
