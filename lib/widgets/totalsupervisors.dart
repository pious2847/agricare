import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:flutter/material.dart';
// Import your utility function here

class TotalSupervisorWidget extends StatefulWidget {
  const TotalSupervisorWidget({super.key});

  @override
  State<TotalSupervisorWidget> createState() => _TotalSupervisorWidgetState();
}

class _TotalSupervisorWidgetState extends State<TotalSupervisorWidget> {
  late Future<int> _TotalSupervisors;

   late final SupervisorCrud supervisorcrud =
      DatabaseHelper.instance.supervisorCrudInstance;

  @override
  void initState() {
    super.initState();
    _TotalSupervisors = supervisorcrud.getTotalSupervisors();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _TotalSupervisors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching the data
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show an error message if fetching fails
        } else {
          return Text(
            '${snapshot.data}',
            style: TextStyle(
                fontSize: 54.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(136, 45, 218, 131)),
          );
        }
      },
    );
  }
}
