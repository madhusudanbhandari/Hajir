import 'package:flutter/material.dart ';
import 'package:flutter_application_1/Provider/dashboard_provider.dart';
import 'package:flutter_application_1/Screens/login_page.dart';
import 'package:flutter_application_1/Screens/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Hajir"), centerTitle: true),
      //body: Center(child: Image.asset("logo.jpg")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dashboard.when(
            data: (data) => Text("Total Students:${data['totalStudents']}"),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, _) => Text("Error: $e"),
          ),
          Text(
            "Welcome",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text("Are you new here?"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                ),
                child: Text("Yes"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: Text("No"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
