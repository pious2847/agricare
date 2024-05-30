import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class EmployeeForm extends StatefulWidget {
  final Employee? employee;

  const EmployeeForm({Key? key, this.employee}) : super(key: key);

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _databaseHelper = DatabaseHelper.instance;
  int? _selectedFarmId;
  List<int> _selectedMachineIds = [];
  List<Farm> _farms = [];
  List<Machinery> _machines = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.employee?.name ?? '';
    _contactController.text = widget.employee?.contact ?? '';
    _selectedFarmId = widget.employee?.farmAssigned;
    _selectedMachineIds = widget.employee?.machineAssigned ?? [];
    _loadFarms();
    _loadMachines();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _loadFarms() async {
    _farms = await _databaseHelper.farmCrud.getFarms();
    setState(() {});
  }

  Future<void> _loadMachines() async {
    _machines = await _databaseHelper.machineryCrud.getMachinery();
    setState(() {});
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        contact: _contactController.text,
        machineAssigned: _selectedMachineIds,
        farmAssigned: _selectedFarmId,
      );

      if (widget.employee == null) {
        await _databaseHelper.employeeCrud.addEmployee(employee);
      } else {
        await _databaseHelper.employeeCrud.updateEmployee(employee);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<int>(
                value: _selectedFarmId,
                onChanged: (value) {
                  setState(() {
                    _selectedFarmId = value;
                  });
                },
                items: _farms.map((farm) {
                  return DropdownMenuItem<int>(
                    value: farm.id,
                    child: Text(farm.name),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Assigned Farm'),
              ),
              const SizedBox(height: 16.0),
              MultiSelectChipField<int>(
                items: _machines
                    .map((machine) => MultiSelectItem<int>(machine.id!, machine.name))
                    .toList(),
                initialValue: _selectedMachineIds,
                title: const Text('Assigned Machines'),
                headerColor: Colors.blue.withOpacity(0.5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.8),
                ),
                selectedChipColor: Colors.blue.withOpacity(0.5),
                selectedTextStyle: TextStyle(color: Colors.blue[800]),
                onTap: (values) {
                  setState(() {
                    _selectedMachineIds = values.cast<int>();
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveEmployee,
          child: Text(widget.employee == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

