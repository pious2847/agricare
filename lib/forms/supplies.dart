import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:flutter/material.dart';
import 'package:agricare/database/databaseHelper.dart';

class SuppliesModal extends StatefulWidget {
  final Supplies? supplies;

  const SuppliesModal({Key? key, this.supplies,}) : super(key: key);

  @override
  _SuppliesModalState createState() => _SuppliesModalState();
}

class _SuppliesModalState extends State<SuppliesModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _productController;
  late TextEditingController _stockController;
  late TextEditingController _descriptionController;

  // Use the suppliesCrudInstance getter
  late final SuppliesCrud _suppliesCrud = DatabaseHelper.instance.suppliesCrudInstance;

  @override
  void initState() {
    super.initState();
    _productController = TextEditingController(text: widget.supplies?.product ?? '');
    _stockController =
        TextEditingController(text: '${widget.supplies?.stock}' ?? '0');
    _descriptionController =
        TextEditingController(text: widget.supplies?.description ?? '');
  }

  @override
  void dispose() {
    _productController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _savesupplies() async {
    if (_formKey.currentState!.validate()) {
      final supplies = Supplies(
        id: widget.supplies?.id,
        product: _productController.text,
        stock:  int.parse(_stockController.text),
        description: _descriptionController.text,
      );

      if (widget.supplies == null) {
        await _suppliesCrud.addSupplies(supplies);
        setState(() {});
        Navigator.of(context).pop();
        print("supplies iserted $supplies");
      } else {
        await _suppliesCrud.updateSupplies(supplies);
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
      title: const Text('Add Supplies'),
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
              controller: _stockController,
              decoration: const InputDecoration(labelText: 'Stock'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a stock';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'descriptions',),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the supplies description';
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
            onPressed: _savesupplies,
            child: Text(widget.supplies == null ? 'Add' : 'Save'),
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
