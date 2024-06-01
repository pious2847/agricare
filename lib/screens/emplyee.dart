import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  late final EmployeeCrud _employeeCrud = DatabaseHelper.instance.employeeCrudInstance;
  late final MachineryCrud _machineryCrud = DatabaseHelper.instance.machineryCrud;

  late List<Employee> _employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    _employees = await _employeeCrud.getEmployees();
    setState(() {});
  }

  void _deleteEmployee(int id) async {
    await _employeeCrud.deleteEmployee(id);
    _loadEmployees();
  }

  void _editEmployee(Employee employee) {
    // Open the EmployeeForm for editing here
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          if (_employees.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('Machinery Assigned')),
                    DataColumn(label: Text('Farm Assigned')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _employees.map((employee) {
                    final machineNames = employee.machinery_id?.map((id) {
                      final machine = _machineryCrud.getMachineById(id);
                      return machine?.name ?? '';
                    }).join(', ') ?? '';

                    final farmName = _farmCrud.getFarmById(employee.farmAssigned)?.name ?? '';

                    return DataRow(
                      cells: [
                        DataCell(Text(employee.name)),
                        DataCell(Text(employee.contact)),
                        DataCell(Text(machineNames)),
                        DataCell(Text(farmName)),
                        DataCell(Column(children: [
                           IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editEmployee(employee),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteEmployee(employee.id!),
                            ),
                        ],))
                       
                      ],
                    );
                  }).toList(),
                ),
              ),
            )
          else
            const Text('No records found'),
        ],
      ),
    );
  }
}