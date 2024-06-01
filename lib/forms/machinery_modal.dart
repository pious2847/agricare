import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:flutter/material.dart';


class MachineryModal extends StatefulWidget {
  final Machinery? machinery;

  const MachineryModal({Key? key, this.machinery}) : super(key: key);

  @override
  _MachineryModalState createState() => _MachineryModalState();
}

class _MachineryModalState extends State<MachineryModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _tagNumberController;
    
    // Use the machineryCrudInstance getter
  late final MachineryCrud _machineryCrud = DatabaseHelper.instance.machineryCrudInstance;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.machinery?.name ?? '');
    _tagNumberController =
        TextEditingController(text: widget.machinery?.tagNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tagNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveMachinery() async {
    if (_formKey.currentState!.validate()) {
      final machinery = Machinery(
        id: widget.machinery?.id,
        name: _nameController.text,
        tagNumber: _tagNumberController.text,
      );

      if (widget.machinery == null) {
        await _machineryCrud.addMachinery(machinery);
      Navigator.of(context).pop();
      } else {
        await _machineryCrud.updateMachinery(machinery);
      Navigator.of(context).pop();
      }    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Machinery'),
      content: Form(
        key: _formKey,
        child: Column(
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
              controller: _tagNumberController,
              decoration: const InputDecoration(labelText: 'Tag Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a tag number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveMachinery,
              child: Text(widget.machinery == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}