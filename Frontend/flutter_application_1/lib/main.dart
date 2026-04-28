import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/admin_dashboard.dart';
import 'package:flutter_application_1/Screens/student_dashboard.dart';
import 'package:flutter_application_1/Screens/teacher_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.wait([getToken(), getRole()]),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final token = snapshot.data[0];
          final role = snapshot.data[1];

          if (token == null) return LoginScreen();

          if (role == "student") return StudentDashboard();
          if (role == "teacher") return TeacherDashboard();
          return AdminDashboard();
        },
      ),
    );
  }
}
