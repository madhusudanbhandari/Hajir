import '../services/api_services.dart';

class AuthService {
  final ApiService api;

  AuthService(this.api);

  Future<String> login(String email, String password) async {
    final data = await api.post("/auth/login", {
      "email": email,
      "password": password,
    });

    return data['token'];
  }
}
