import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/farm.dart';
import 'package:flutter/material.dart';

class SupervisorModal extends StatefulWidget {
  final Supervisor? supervisor;

  const SupervisorModal({Key? key, this.supervisor}) : super(key: key);

  @override
  _SupervisorModalState createState() => _SupervisorModalState();
}

class _SupervisorModalState extends State<SupervisorModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _notesController;

  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Farm> _farms = [];

  int? _selectedFarmId;

  @override
  void initState() {
    super.initState();
    loadFarms();
    _nameController =
        TextEditingController(text: widget.supervisor?.name ?? '');
    _contactController =
        TextEditingController(text: widget.supervisor?.contact ?? '');
        _notesController =
        TextEditingController(text: widget.supervisor?.notes ?? '');
        _selectedFarmId = widget.supervisor?.farmsAssigned;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    super.dispose();
  }
 Future<void> loadFarms() async {
    _farms = await _farmCrud.getFarms();
    setState(() {});
  }

  Future<void> _savesupervisor() async {
    if (_formKey.currentState!.validate()) {
      final supervisor = Supervisor(
        id: widget.supervisor?.id,
        name: _nameController.text,
        contact: _nameController.text,
        notes: _notesController.text,
        farmsAssigned: _selectedFarmId,

      );

      final databaseHelper = DatabaseHelper.instance;

      if (widget.supervisor == null) {
        await databaseHelper.supervisorcrud.addSupervisor(supervisor);
      } else {
        await databaseHelper.supervisorcrud.updateSupervisor(supervisor);
      }

      // Close the modal after saving
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add supervisor'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact';
                }
                return null;
              },
            ),
            
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
              
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        const SizedBox(height: 16.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: ElevatedButton(
            onPressed: _savesupervisor,
            child: Text(widget.supervisor == null ? 'Add' : 'Save'),
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
