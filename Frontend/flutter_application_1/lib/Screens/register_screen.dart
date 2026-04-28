import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final role = TextEditingController();
  final auth = AuthService();

  void register(BuildContext context) async {
    await auth.register(name.text, email.text, password.text, role.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(hintText: "Name"),
          ),
          SizedBox(height: 5),
          TextField(
            controller: email,
            decoration: InputDecoration(hintText: "Email"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: password,
            decoration: InputDecoration(hintText: "Password"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: role,
            decoration: InputDecoration(
              hintText: "Role (student/teacher/admin)",
            ),
          ),
          ElevatedButton(
            onPressed: () => register(context),
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}
