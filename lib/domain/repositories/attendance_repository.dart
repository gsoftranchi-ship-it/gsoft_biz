import '../../models/attendance_model.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceModel>> loadAttendance({
    required String gymId,
  });

  Future<void> markAttendance(
      AttendanceModel attendance,
      );

  Future<void> updateAttendance(
      AttendanceModel attendance,
      );
}