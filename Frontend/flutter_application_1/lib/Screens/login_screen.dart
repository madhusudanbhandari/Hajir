import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/admin_dashboard.dart';
import 'package:flutter_application_1/Screens/register_screen.dart';
import 'package:flutter_application_1/Screens/student_dashboard.dart';
import 'package:flutter_application_1/Screens/teacher_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final auth = AuthService();

  void login(BuildContext context) async {
    final res = await auth.login(email.text, password.text);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", res["token"]);
    await prefs.setString("role", res["user"]["role"]);

    String role = res["user"]["role"];

    if (role == "student") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StudentDashboard()),
      );
    } else if (role == "teacher") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => TeacherDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );
              },
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
