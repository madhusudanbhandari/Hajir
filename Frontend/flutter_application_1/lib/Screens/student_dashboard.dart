import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/attendance_service.dart';
import 'login_screen.dart';

class StudentDashboard extends StatefulWidget {
  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final service = AttendanceService();

  bool isLoading = false;
  String statusMessage = "Not Marked Yet";

  Future<void> markAttendance() async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;

    try {
      final res = await service.markAttendance(token);

      print("ATTENDANCE RESPONSE: $res");

      setState(() {
        statusMessage = "Attendance Marked ✅";
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Attendance marked successfully")));
    } catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to mark attendance")));
    }

    setState(() => isLoading = false);
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget buildCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, VoidCallback onPressed, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Student Dashboard"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            /// 👋 Welcome Card
            buildCard("Welcome", "Student", Icons.person),

            /// 📊 Attendance Status
            buildCard("Today's Status", statusMessage, Icons.check_circle),

            SizedBox(height: 20),

            /// ✅ Mark Attendance
            isLoading
                ? CircularProgressIndicator()
                : buildButton("Mark Attendance", markAttendance, Colors.green),

            /// 📅 View History (placeholder)
            buildButton("View Attendance History", () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Coming Soon 🚀")));
            }, Colors.orange),

            /// 🚪 Logout
            buildButton("Logout", logout, Colors.red),
          ],
        ),
      ),
    );
  }
}
