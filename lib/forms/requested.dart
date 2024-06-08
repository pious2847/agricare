import 'package:agricare/models/farm.dart';
import 'package:agricare/models/requested.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/requested.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:flutter/material.dart';
import 'package:agricare/database/databaseHelper.dart';

class RequestedModal extends StatefulWidget {
  final Requested? requested;

  const RequestedModal({
    Key? key,
    this.requested,
  }) : super(key: key);

  @override
  _RequestedModalState createState() => _RequestedModalState();
}

class _RequestedModalState extends State<RequestedModal> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _quantityController;

  // Use the requestedCrudInstance getter
  late final RequestedCrud _requestedCrud =
      DatabaseHelper.instance.requestedCrudInstance;
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  late final SuppliesCrud _suppliesCrud =
      DatabaseHelper.instance.suppliesCrudInstance;

  String? _selectedFarm;
  String? _selectedsupply;
  List<Farm> _farms = [];
  List<Supplies> _supplies = [];

  @override
  void initState() {
    super.initState();
    loadSupplies();
    loadFarms();
    _selectedsupply = widget.requested?.product;
    _quantityController =
        TextEditingController(text: '${widget.requested?.quantity ?? ''}',);
    _selectedFarm = widget.requested?.farmRequesting;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> loadFarms() async {
    _farms = await _farmCrud.getFarms();
    if (_selectedFarm == null && _farms.isNotEmpty) {
      _selectedFarm = _farms[0].name; // Set a default value
    }
    setState(() {});
  }

  Future<void> loadSupplies() async {
    _supplies = await _suppliesCrud.getSupplies();
    if (_selectedsupply == null && _supplies.isNotEmpty) {
      _selectedsupply = _supplies[0].product; // Set a default value
    }
    setState(() {});
  }

  Future<void> _saverequested() async {
    if (_formKey.currentState!.validate()) {
      final requested = Requested(
        id: widget.requested?.id,
        product: '$_selectedsupply',
        quantity: int.parse(_quantityController.text),
        farmRequesting: '$_selectedFarm',
        approved: 1
      );

      if (widget.requested == null) {
        await _requestedCrud.addRequested(requested, '$_selectedsupply');
        setState(() {});
        Navigator.of(context).pop();
        print("requested inserted $requested");
      } else {
        await _requestedCrud.updateRequested(requested);
        setState(() {});
        // Close the modal after saving
        Navigator.of(context).pop();
      }
      // // Close the modal after saving
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add requested'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String?>(
              value: _selectedsupply,
              onChanged: (value) {
                setState(() {
                  _selectedsupply = value!;
                });
              },
              items: _supplies.map((supply) {
                return DropdownMenuItem<String>(
                  value: supply.product,
                  child: Text(supply.product),
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
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Stock'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                final selectedsupply = _supplies.singleWhere((supply) => supply.product == _selectedsupply);
                if (int.parse(value) > selectedsupply.stock) {
                  return 'Insufficient Stock';
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
              validator: (value) {
                if (value == null) {
                  return 'Please select a farm';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: ElevatedButton(
            onPressed: _saverequested,
            child: Text(widget.requested == null ? 'Add' : 'Save'),
          ),
        ),
        const SizedBox(width: 14.0),
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
