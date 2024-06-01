import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/widgets/multi_select.dart';
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

  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  
  late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;
  late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;

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
    _farms = await _farmCrud.getFarms();
    setState(() {});
  }

  Future<void> _loadMachines() async {
    _machines = await _machineryCrud.getMachinery();
    setState(() {});
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        contact: _contactController.text,
        farmAssigned: _selectedFarmId,
      );

      if (widget.employee == null) {
        await _employeeCrud.addEmployee(employee, _selectedMachineIds);
      } else {
        await _employeeCrud.updateEmployee(employee, _selectedMachineIds);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Text('Select Machinery'),
              const SizedBox(height: 16.0),
              CustomMultiSelect(
                items: _machines.map((machine) {
                  return MultiSelectItem<int>(machine.id!, machine.name);
                }).toList(),
                initialValue: _selectedMachineIds,
                onSelectionChanged: (selectedValues) {
                  setState(() {
                    _selectedMachineIds = selectedValues;
                  });
                  print('_selectedMachineIds : $_selectedMachineIds');
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