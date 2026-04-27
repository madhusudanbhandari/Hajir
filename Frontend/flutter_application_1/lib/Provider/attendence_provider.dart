import 'package:flutter_application_1/Provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/attendance_service.dart';
import '../utils/token_storage.dart';

final attendanceProvider = FutureProvider((ref) async {
  final api = ref.read(apiProvider);
  final token = await TokenStorage().getToken();

  if (token == null) throw Exception("No token");

  final service = AttendanceService();
  return service.getAttendance(token);
});
