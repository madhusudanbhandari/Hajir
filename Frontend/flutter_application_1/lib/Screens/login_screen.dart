import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/admin_dashboard.dart';
import 'package:flutter_application_1/Screens/register_screen.dart';
import 'package:flutter_application_1/Screens/student_dashboard.dart';
import 'package:flutter_application_1/Screens/teacher_dashboard.dart';
import 'package:flutter_application_1/custom_widget/button.dart';
import 'package:flutter_application_1/custom_widget/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final auth = AuthService();

  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);

    try {
      final res = await auth.login(email.text.trim(), password.text.trim());

      print("RESPONSE: $res");

      if (res["token"] == null || res["role"] == null) {
        throw Exception("Invalid response from server");
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", res["token"]);
      await prefs.setString("role", res["role"]);

      String role = res["role"];

      if (!mounted) return;

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
      } else if (role == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AdminDashboard()),
        );
      } else {
        // Unknown role → go back to login
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid role received")));
      }
    } catch (e) {
      print("LOGIN ERROR: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed")));
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(hint: 'Email', controller: email),
            SizedBox(height: 10),
            CustomTextField(
              hint: 'Password',
              controller: password,
              // 🔥 important
            ),
            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : CustomButton(onPressed: login, text: 'Login'),

            SizedBox(height: 10),

            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterScreen()),
                );
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
