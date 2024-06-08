import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/models/admin.dart';
import 'package:agricare/utils/admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Admin? admin;

  const SettingsPage({super.key, this.admin});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<Admin?> getAdminCurrent() async {
    // Get the saved admin's ID from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('adminId');
    print('retrieved AdminId $adminId');

    // Retrieve the admin object from the database
    late final adminCrud = DatabaseHelper.instance.adminCrudInstance;

    if (adminId != null) {
      final currentAdmin = await adminCrud.getAdminById(adminId);

      print('Retrieved current Admin $currentAdmin');
      return currentAdmin;
    }

    return null;
  }

  Future<void> _saveAdmin() async {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  const Text('New password and confirm password do not match.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
        return;
      }
      final currentAdmin = await getAdminCurrent();
      if (currentAdmin != null) {
        // Check if the old password matches the current password
        if (_oldPasswordController.text != currentAdmin.password) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('Old password is incorrect.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  )
                ],
              );
            },
          );
          return;
        }
      }

      final admin = Admin(
        id: currentAdmin!.id,
        username: currentAdmin.username,
        password: _newPasswordController.text,
      );

      late final adminCrud = DatabaseHelper.instance.adminCrudInstance;

      await adminCrud.updateAdmin(admin);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Password changed successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Change Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _oldPasswordController,
                  decoration: const InputDecoration(labelText: 'Old Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveAdmin,
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
