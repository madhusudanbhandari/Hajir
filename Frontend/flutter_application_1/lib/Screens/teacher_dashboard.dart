import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/attendance_service.dart';
import 'login_screen.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final service = AttendanceService();

  List students = [
    {"name": "Ram Sharma", "id": "1"},
    {"name": "Sita Rai", "id": "2"},
    {"name": "Hari Thapa", "id": "3"},
  ];

  List filteredStudents = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  void search(String query) {
    setState(() {
      filteredStudents = students
          .where((s) => s["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> markAttendance(String studentId, String status) async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;

    try {
      // You can modify backend to accept studentId & status
      final res = await service.markAttendance(token);

      print("ATTENDANCE: $res");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Marked $status for student")));
    } catch (e) {
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

  Widget buildStudentCard(Map student) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            student["name"],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => markAttendance(student["id"], "Present"),
                  child: Text("Present"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => markAttendance(student["id"], "Absent"),
                  child: Text("Absent"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Teacher Dashboard"),
        backgroundColor: Colors.blue,
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔍 Search Bar
            TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search Students...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 10),

            /// 👨‍🎓 Student List
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        return buildStudentCard(filteredStudents[index]);
                      },
                    ),
            ),

            /// 📊 View Attendance Button
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Coming Soon 🚀")));
              },
              child: Text("View Attendance Records"),
            ),
          ],
        ),
      ),
    );
  }
}
