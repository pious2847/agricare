// ignore_for_file: non_constant_identifier_names

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/utils/farm.dart';
import 'package:flutter/material.dart';
// Import your utility function here

class TotalFarmsWidget extends StatefulWidget {
  @override
  State<TotalFarmsWidget> createState() => _TotalFarmsWidgetState();
}

class _TotalFarmsWidgetState extends State<TotalFarmsWidget> {
  late Future<int> _TotalFarms;

  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  @override
  void initState() {
    super.initState();
    _TotalFarms = _farmCrud.getTotalFarms();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _TotalFarms,
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
