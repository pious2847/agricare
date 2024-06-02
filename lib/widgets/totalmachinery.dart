import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:flutter/material.dart';
import 'package:agricare/utils/employee.dart'; // Import your utility function here

class TotalMachinerysWidget extends StatefulWidget {
  const TotalMachinerysWidget({super.key});

  @override
  State<TotalMachinerysWidget> createState() => _TotalMachinerysWidgetState();
}

class _TotalMachinerysWidgetState extends State<TotalMachinerysWidget> {
     late Future<int> _TotalMachinerys;

 late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;

  @override
  void initState() {
    super.initState();
    _TotalMachinerys = _machineryCrud.getTotalMachinery();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _TotalMachinerys, 
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
              color: Colors.greenAccent,
            ),
          );
        }
      },
    );
  }
}
