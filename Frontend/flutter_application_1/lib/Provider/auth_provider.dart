import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'api_provider.dart';
import '../services/auth_service.dart';
import '../utils/token_storage.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<void>>((
  ref,
) {
  final api = ref.read(apiProvider);
  return AuthNotifier(AuthService());
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService service;

  AuthNotifier(this.service) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final token = await service.login(email, password);

      await TokenStorage().saveToken(token);

      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    state = const AsyncValue.loading();

    try {
      await service.register(name, email, password, role);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
