import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dashboard_service.dart';
import '../Provider/api_provider.dart';
import '../utils/token_storage.dart';

final dashboardProvider = FutureProvider((ref) async {
  final api = ref.read(apiProvider);
  final token = await TokenStorage().getToken();

  if (token == null) throw Exception("No Token");

  final service = DashboardService(api);
  return service.getDashboardData(token);
});
