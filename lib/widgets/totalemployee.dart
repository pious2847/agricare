import 'package:agricare/database/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:agricare/utils/employee.dart'; // Import your utility function here

class TotalEmployeesWidget extends StatefulWidget {
  @override
  State<TotalEmployeesWidget> createState() => _TotalEmployeesWidgetState();
}

class _TotalEmployeesWidgetState extends State<TotalEmployeesWidget> {
     late Future<int> _totalEmployees;

 late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;

  @override
  void initState() {
    super.initState();
    _totalEmployees = _employeeCrud.getTotalEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _totalEmployees, 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching the data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show an error message if fetching fails
        } else {
          return Text(
            '${snapshot.data}',
            style: TextStyle(
              fontSize: 54.0,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          );
        }
      },
    );
  }
}
