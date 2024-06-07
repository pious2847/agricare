// ignore_for_file: non_constant_identifier_names

import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:flutter/material.dart';
// Import your utility function here

class TotalSuppliesWidget extends StatefulWidget {
  const TotalSuppliesWidget({super.key});

  @override
  State<TotalSuppliesWidget> createState() => _TotalSuppliesWidgetState();
}

class _TotalSuppliesWidgetState extends State<TotalSuppliesWidget> {
  late Future<int> _TotalSupplies;

  late final SuppliesCrud _suppliesCrud = DatabaseHelper.instance.suppliesCrudInstance;

  @override
  void initState() {
    super.initState();
    _TotalSupplies = _suppliesCrud.getTotalSupplies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _TotalSupplies,
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
