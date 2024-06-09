import 'package:agricare/constants/layout.dart';
import 'package:agricare/database/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AdminCrud = DatabaseHelper.instance.adminCrudInstance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addDefaultAdmin();
      PopLoginModal();
    });
  }

  void PopLoginModal() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => showContentDialog(),
    );
  }

  void addDefaultAdmin() async {
    final pref = await SharedPreferences.getInstance();
   late final alreadyadded = pref.getBool('admincreated');
    
    if (alreadyadded !=  true) {
      await AdminCrud.insertDefaultAdmin();
      final pref = await SharedPreferences.getInstance();
      pref.setBool('admincreated', true);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Image(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final admin = await DatabaseHelper.instance.adminCrudInstance
          .getAdminByUsername(username);

      if (admin != null && admin.password == password) {
        // Save the admin's ID using shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('adminId', admin.id);

        // Navigate to the dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LayoutScreen()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Invalid username or password'),
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
  }

  Widget showContentDialog() {
    return Container(
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Login'),
        content: SizedBox(
          width: 350,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Login'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
