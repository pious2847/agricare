import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/employee.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;

  List<Employee> _employees = [];
  List<Farm> _farms = [];
  List<Machinery> _machines = [];

  @override
  void initState() {
    super.initState();
    loadData(); 
    _loadEmployees();
  }


  void _deleteEmployee(int id) async {
    await _employeeCrud.deleteEmployee(id);
    loadData();
  }

  void _editEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => EmployeeForm(
        employee: employee,
        onEmployeeSaved: loadData,
      ),
    );
  }

  Future<void> loadData() async {
    _employees = await _employeeCrud.getEmployees();
    _farms = await _farmCrud.getFarms();
    _machines = await _machineryCrud.getMachinery();
    setState(() {});
  }

  String getFarmName(int? farmId) {
    if (farmId == null) return '';
    Farm? farm = _farms.firstWhere((f) => f.id == farmId);
    return farm.name;
  }

  // List<String> getMachineNames(Employee employee) {
  //   List<String> machineNames = [];
  //   for (int machineId in employee.machineIds ?? []) {
  //     Machinery? machine = _machines.firstWhere((m) => m.id == machineId);
  //     if (machine != null) {
  //       machineNames.add(machine.name);
  //     }
  //   }
  //   return machineNames;
  // }

  Future<void> _loadEmployees() async {
    _employees = await _employeeCrud.getEmployees();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [],
      ),
    );
  }
}
