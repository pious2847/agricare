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
  late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;

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

      try {
        if (widget.machinery == null) {
          await _machineryCrud.addMachinery(machinery);
          setState(() {});
          print('Machinery added');
        } else {
          await _machineryCrud.updateMachinery(machinery);
          setState(() {});
        }
        Navigator.of(context).pop();
      } catch (e) {
        // Handle errors appropriately
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title:
          Text(widget.machinery == null ? 'Add Machinery' : 'Edit Machinery'),
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
           
          ],
        ),
      ),
      actions: [
         const SizedBox(height: 16.0),
            SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
              child: ElevatedButton(
                onPressed: _saveMachinery,
                child: Text(widget.machinery == null ? 'Add' : 'Save'),
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
