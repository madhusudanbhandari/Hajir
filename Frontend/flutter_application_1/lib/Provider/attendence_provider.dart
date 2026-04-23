import 'package:flutter_application_1/Provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/attendence_service.dart';
import '../utils/token_storage.dart';

final attendenceProvider = FutureProvider((ref) async {
  final api = ref.read(apiProvider);
  final token = await TokenStorage().getToken();

  if (token == null) throw Exception("No token");

  final service = AttendenceService(api);
  return service.getAttendence(token);
});
