import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:flutter/material.dart';

class SupervisorModal extends StatefulWidget {
  final Supervisor? supervisor;

  const SupervisorModal({Key? key, this.supervisor}) : super(key: key);

  @override
  _SupervisorModalState createState() => _SupervisorModalState();
}

class _SupervisorModalState extends State<SupervisorModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _notesController = TextEditingController();

  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  late final SupervisorCrud supervisorcrud =
      DatabaseHelper.instance.supervisorCrudInstance;

  List<Farm> _farms = [];

  String? _selectedFarm;

  @override
  void initState() {
    loadFarms();
    super.initState();
    _nameController.text = widget.supervisor?.name ?? '';
    _contactController.text = widget.supervisor?.contact ?? '';
    _notesController.text = widget.supervisor?.notes ?? '';
    _selectedFarm = widget.supervisor?.farmsAssigned ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        contact: _contactController.text,
        notes: _notesController.text,
        farmsAssigned: _selectedFarm,
      );

      if (widget.supervisor == null) {
        await supervisorcrud.addSupervisor(supervisor);
      } else {
        await supervisorcrud.updateSupervisor(supervisor);
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
              decoration: const InputDecoration(labelText: 'contact'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact';
                }
                return null;
              },
            ),
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
            ),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'notes'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a notes';
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
