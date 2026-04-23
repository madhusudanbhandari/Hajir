import '../services/api_service.dart';

class DashboardService {
  final ApiService api;

  DashboardService(this.api);

  Future<dynamic> getDashboardData(String token) async {
    return await api.get("/dashboard", token);
  }
}
