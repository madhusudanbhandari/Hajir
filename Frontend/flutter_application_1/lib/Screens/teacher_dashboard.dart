import 'package:flutter/material.dart';

class TeacherDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teacher Dashboard")),
      body: Center(child: Text("View and manage attendance")),
    );
  }
}
