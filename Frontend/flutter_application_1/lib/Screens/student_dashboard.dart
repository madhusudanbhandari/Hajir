import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/attendance_service.dart';
import 'login_screen.dart';

class StudentDashboard extends StatelessWidget {
  final service = AttendanceService();

  void markAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    await service.markAttendance(token);
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Dashboard")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: markAttendance,
            child: Text("Mark Attendance"),
          ),
          ElevatedButton(
            onPressed: () => logout(context),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
