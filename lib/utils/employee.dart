import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeCrud {
  // final DatabaseHelper _dbHelper = DatabaseHelper.instance;
      final DatabaseHelper _dbHelper;
    EmployeeCrud(this._dbHelper);
  

  Future<int> addEmployee(Employee employee, List<int> machineIds) async {
    Database db = await _dbHelper.initDb();
    int employeeId = await db.insert('employee', employee.toMap());
    for (int machineId in machineIds) {
      await db.insert('employee_machinery', {
        'employee_id': employeeId,
        'machinery_id': machineId,
      });
    }
    return employeeId;
  }

  Future<List<Employee>> getEmployees() async {
    Database db = await _dbHelper.initDb();
    var employees = await db.query(
      'employee e LEFT JOIN employee_machinery em ON e.id = em.employee_id',
      columns: [
        'e.id',
        'e.name',
        'e.contact',
        'e.farmAssigned',
        'em.machinery_id',
      ],
    );

    Map<int, Employee> employeeMap = {};
    List<Employee> result = [];

    for (var employee in employees) {
      int? employeeId = employee['id'] as int?;
      if (!employeeMap.containsKey(employeeId)) {
        employeeMap[employeeId!] = Employee(
          id: employeeId,
          name: employee['name'] as String,
          contact: employee['contact'] as String,
          farmAssigned: employee['farmAssigned'] as int?,
        );
        result.add(employeeMap[employeeId]!);
      }
    }

    return result;
  }

  Future<int> updateEmployee(Employee employee, List<int> machineIds) async {
    Database db = await _dbHelper.initDb();
    int rowsAffected = await db.update('employee', employee.toMap(), where: 'id = ?', whereArgs: [employee.id]);

    // Delete existing machinery assignments
    await db.delete('employee_machinery', where: 'employee_id = ?', whereArgs: [employee.id]);

    // Insert new machinery assignments
    for (int machineId in machineIds) {
      await db.insert('employee_machinery', {
        'employee_id': employee.id,
        'machinery_id': machineId,
      });
    }

    return rowsAffected;
  }

  Future<int> deleteEmployee(int id) async {
    Database db = await _dbHelper.initDb();
    await db.delete('employee_machinery', where: 'employee_id = ?', whereArgs: [id]);
    return await db.delete('employee', where: 'id = ?', whereArgs: [id]);
  }
}
