import '../services/api_service.dart';

class AttendenceService {
  final ApiService api;

  AttendenceService(this.api);

  Future<List> getAttendence(String token) async {
    return await api.get("/attendence", token);
  }
}
