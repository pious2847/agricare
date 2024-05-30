import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/admin.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/utils/farm.dart';
import 'package:flutter/material.dart';


class AdminModal extends StatefulWidget {
  final Admin? admin;

  const AdminModal({Key? key, this.admin}) : super(key: key);

  @override
  _AdminModalState createState() => _AdminModalState();
}

class _AdminModalState extends State<AdminModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.admin?.username ?? '');
    _passwordController =
        TextEditingController(text: widget.admin?.password ?? '');
  
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveAdmin() async {
    if (_formKey.currentState!.validate()) {
      final admin = Admin(
        id: widget.admin?.id,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      final databaseHelper = DatabaseHelper.instance;

      if (widget.admin == null) {
          
        await databaseHelper.admincrud.addAdmin(admin);
      } else {
        await databaseHelper.admincrud.updateAdmin(admin);
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
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveAdmin,
              child: Text(widget.admin == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}