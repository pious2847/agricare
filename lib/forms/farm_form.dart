import 'package:agricare/models/farm.dart';
import 'package:agricare/utils/farm.dart';
import 'package:flutter/material.dart';
import 'package:agricare/database/databaseHelper.dart';

class FarmModal extends StatefulWidget {
  final Farm? farm;

  const FarmModal({Key? key, this.farm}) : super(key: key);

  @override
  _FarmModalState createState() => _FarmModalState();
}

class _FarmModalState extends State<FarmModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _farmProduceController;

  // Use the farmCrudInstance getter
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.farm?.name ?? '');
    _locationController =
        TextEditingController(text: widget.farm?.location ?? '');
    _farmProduceController =
        TextEditingController(text: widget.farm?.farmproduce ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _farmProduceController.dispose();
    super.dispose();
  }

  Future<void> _saveFarm() async {
    if (_formKey.currentState!.validate()) {
      final farm = Farm(
        id: widget.farm?.id,
        name: _nameController.text,
        location: _locationController.text,
        farmproduce: _farmProduceController.text,
      );

      if (widget.farm == null) {
        await _farmCrud.addFarm(farm);
      } else {
        await _farmCrud.updateFarm(farm);
      }

      // Close the modal after saving
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Farm'),
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
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _farmProduceController,
              decoration: const InputDecoration(labelText: 'Farm Produce'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the farm produce';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveFarm,
              child: Text(widget.farm == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}