import '../services/api_service.dart';

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

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    await api.post("auth/register", {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });
  }
}
