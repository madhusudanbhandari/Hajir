import 'api_service.dart';

class AttendanceService {
  final api = ApiService();

  Future markAttendance(String token) async {
    return await api.post("attendance/mark", {}, token);
  }

  Future getAttendance(String token) async {
    return await api.get("attendance", token);
  }
}
