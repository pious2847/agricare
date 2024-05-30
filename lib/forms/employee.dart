import 'package:agricare/models/employee.dart';
import 'package:agricare/utils/employee.dart';
import 'package:flutter/material.dart';

class EmployeeForm extends StatefulWidget {
  
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String contact = '';
  late EmployeeCrud employeeform = EmployeeCrud() ;

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> employee = {
        'name': name,
        'contact': contact,
      };

      await employeeform.addEmployee(employee as Employee);
      print("Saved Employee: $employee ");

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Employee'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                name = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Contact'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a contact';
                }
                return null;
              },
              onSaved: (value) {
                contact = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveForm,
          child: Text('Save'),
        ),
      ],
    );
  }
}
