import 'package:flutter/material.dart';
import 'package:flutter_application_1/Provider/dashboard_provider.dart';
import 'package:flutter_application_1/Screens/login_page.dart';
import 'package:flutter_application_1/utils/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hajir Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await TokenStorage().clearToken();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      body: dashboard.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(
          child: Text("Error: $e", style: const TextStyle(color: Colors.red)),
        ),

        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 👤 USER INFO
                Card(
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.person, size: 40),
                    title: Text(data['name'] ?? "User"),
                    subtitle: Text("Role: ${data['role'] ?? "N/A"}"),
                  ),
                ),

                const SizedBox(height: 20),

                /// 📊 DASHBOARD STATS
                Text("Overview", style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _buildCard(
                      title: "Students",
                      value: "${data['totalStudents'] ?? 0}",
                      icon: Icons.school,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 10),
                    _buildCard(
                      title: "Attendance",
                      value: "${data['attendanceRate'] ?? 0}%",
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 📅 ACTIONS
                Text(
                  "Quick Actions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to attendance screen
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text("View Attendance"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add future feature
                  },
                  icon: const Icon(Icons.notifications),
                  label: const Text("View Notifications"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Reusable Card Widget
  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
