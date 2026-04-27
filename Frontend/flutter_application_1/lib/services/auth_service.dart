import '../services/api_service.dart';

class AuthService {
  final api = ApiService();

  Future login(String email, String password) async {
    return await api.post("/auth/login", {
      "email": email,
      "password": password,
    });
  }

  Future register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    await api.post("/auth/register", {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });
  }
}
