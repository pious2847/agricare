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

class EmployeeModal extends StatefulWidget {
  final Employee? employee;
  final VoidCallback? onEmployeeSaved;
  const EmployeeModal({Key? key, this.employee, this.onEmployeeSaved})
      : super(key: key);

  @override
  _EmployeeModalState createState() => _EmployeeModalState();
}

class _EmployeeModalState extends State<EmployeeModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;
  late final EmployeeCrud _employeeCrud =
      DatabaseHelper.instance.employeeCrudInstance;

  String? _selectedFarm;
  List<String> _selectedMachineIds = [];
  List<Farm> _farms = [];
  List<Machinery> _machines = [];

  @override
  void initState() {
    loadFarms();
    loadMachines();
    super.initState();
    _nameController.text = widget.employee?.name ?? '';
    _contactController.text = widget.employee?.contact ?? '';
    _selectedFarm = widget.employee?.farmAssigned;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> loadFarms() async {
    _farms = await _farmCrud.getFarms();
     if (_selectedFarm == null && _farms.isNotEmpty) {
      _selectedFarm = _farms[0].name; // Set a default value
    }
    setState(() {});
  }

  Future<void> loadMachines() async {
    _machines = await _machineryCrud.getMachinery();
    setState(() {});
  }

  Future<void> _saveEmployee() async {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        contact: _contactController.text,
        farmAssigned: _selectedFarm,
        machineryAssigned: _selectedMachineIds.join('/'),
      );

      if (widget.employee == null) {
        await _employeeCrud.addEmployee(
          employee,
        );
        // Call the callback function after saving the employee
        setState(() {
          widget.onEmployeeSaved?.call();
        });
      } else {
        await _employeeCrud.updateEmployee(employee);
        setState(() {
          widget.onEmployeeSaved?.call();
        });
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              const SizedBox(width: 200.0),
              DropdownButtonFormField<String?>(
                value: _selectedFarm,
                onChanged: (value) {
                  setState(() {
                    _selectedFarm = value!;
                  });
                },
                items: _farms.map((farm) {
                  return DropdownMenuItem<String>(
                    value: farm.name,
                    child: Text(farm.name),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Select Farm'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a farm';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              const Text('Select Machinery'),
              const SizedBox(height: 16.0),
              CustomMultiSelect(
                items: _machines.map((machine) {
                  return MultiSelectItem<String>(machine.name, machine.name);
                }).toList(),
                initialValue: _selectedMachineIds,
                onSelectionChanged: (selectedValues) {
                  setState(() {
                    _selectedMachineIds = selectedValues;
                  });
                  print('_selectedMachineIds : ${_selectedMachineIds.join('/')}');
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: ElevatedButton(
            onPressed: _saveEmployee,
            child: Text(widget.employee == null ? 'Add' : 'Save'),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
