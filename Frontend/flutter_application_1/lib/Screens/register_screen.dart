import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_widget/button.dart';
import 'package:flutter_application_1/custom_widget/text_field.dart';
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
          CustomTextField(hint: 'Name', controller: name),
          SizedBox(height: 5),
          CustomTextField(hint: 'Email', controller: email),
          SizedBox(height: 10),
          CustomTextField(hint: 'Password', controller: password),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Select Role"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("Student"),
                        onTap: () {
                          role.text = "student";
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("Teacher"),
                        onTap: () {
                          role.text = "teacher";
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("Admin"),
                        onTap: () {
                          role.text = "admin";
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Text('Select Role'),
          ),
          SizedBox(height: 5),
          CustomButton(onPressed: () => register(context), text: 'Register'),
        ],
      ),
    );
  }
}
