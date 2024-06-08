import 'dart:async';

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeCrud {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

// Future<int> getTotalEmployees() async {
//   Database db = await _dbHelper.initDb();
//   List<Map<String, Object?>> result = await db.query('employee');
//   return result.length;
// }
  final _employeeCountController = StreamController<int>.broadcast();

  Stream<int> get employeeCountStream => _employeeCountController.stream;

  Future<int> getTotalEmployees() async {
    Database db = await _dbHelper.initDb();
    List<Map<String, Object?>> result = await db.query('employee');
    int totalEmployees = result.length;
    _employeeCountController.sink.add(totalEmployees);
    return totalEmployees;
  }

  Future<int> addEmployee(
    Employee employee,
  ) async {
    Database db = await _dbHelper.initDb();
    return await db.insert('employee', employee.toMap());
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await _dbHelper.initDb();
    var employees = await db.query('employee');

    return employees.map((employee) => Employee(
        id: employee['id'] as int?,
        name: employee['name'] as String,
        contact: employee['contact'] as String,
        farmAssigned: employee['farmAssigned'] as String,
        machineryAssigned: employee['machineryAssigned'] as String)).toList();
  }

  Future<int> updateEmployee(Employee employee, ) async {
    Database db = await _dbHelper.initDb();
    return await db.update('employee', employee.toMap(), where: 'id = ?', whereArgs: [employee.id]);
  }

  Future<int> deleteEmployee(int id) async {
    Database db = await _dbHelper.initDb();
    return await db.delete('employee', where: 'id = ?', whereArgs: [id]);

  }

  void dispose() {
    _employeeCountController.close();
  }
}
