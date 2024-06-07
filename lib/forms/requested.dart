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

  const RequestedModal({Key? key, this.requested,}) : super(key: key);

  @override
  _RequestedModalState createState() => _RequestedModalState();
}

class _RequestedModalState extends State<RequestedModal> {
  final _formKey = GlobalKey<FormState>();
 
  late TextEditingController _productController;
  late TextEditingController _quantityController;
  late TextEditingController _farmRequestingController;

  // Use the requestedCrudInstance getter
  late final RequestedCrud _requestedCrud = DatabaseHelper.instance.requestedCrudInstance;
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;
  
  String? _selectedFarm;
  List<Farm> _farms = [];


  @override
  void initState() {
    super.initState();
    _productController = TextEditingController(text: widget.requested?.product ?? '');
    _quantityController =
        TextEditingController(text: '${widget.requested?.quantity}' ?? ' ');
    _selectedFarm = widget.requested?.farmRequesting;

    _farmRequestingController =
        TextEditingController(text: widget.requested?.farmRequesting ?? '');
  }


  @override
  void dispose() {
    _productController.dispose();
    _quantityController.dispose();
    _farmRequestingController.dispose();
    super.dispose();
  }

   Future<void> loadFarms() async {
    _farms = await _farmCrud.getFarms();
     if (_selectedFarm == null && _farms.isNotEmpty) {
      _selectedFarm = _farms[0].name; // Set a default value
    }
    setState(() {});
  }

  Future<void> _saverequested() async {
    if (_formKey.currentState!.validate()) {
      final requested = Requested(
        id: widget.requested?.id,
        product: _productController.text,
        quantity:  int.parse(_quantityController.text),
        farmRequesting: _farmRequestingController.text,
      );

      if (widget.requested == null) {
        await _requestedCrud.addRequested(requested);
        setState(() {});
        Navigator.of(context).pop();
        print("requested iserted $requested");
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
      backgroundColor: Colors.white ,
      title: const Text('Add requested'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _productController,
              decoration: const InputDecoration(labelText: 'Product'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product';
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
                return null;
              },
            ),
            TextFormField(
              controller: _farmRequestingController,
              decoration: const InputDecoration(labelText: 'descriptions',),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the requested description';
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
