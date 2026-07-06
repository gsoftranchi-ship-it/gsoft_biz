import '../../../domain/repositories/attendance_repository.dart';
import '../../../models/attendance_model.dart';
import '../../datasources/remote/firebase/attendance_datasource.dart';

class AttendanceRepositoryImpl
    implements AttendanceRepository {
  AttendanceRepositoryImpl({
    AttendanceDataSource? dataSource,
  }) : _dataSource =
      dataSource ?? AttendanceDataSource();

  final AttendanceDataSource _dataSource;

  @override
  Future<List<AttendanceModel>> loadAttendance({
    required String gymId,
  }) {
    return _dataSource.loadAttendance(
      gymId: gymId,
    );
  }

  @override
  Future<void> markAttendance(
      AttendanceModel attendance,
      ) {
    return _dataSource.markAttendance(
      attendance,
    );
  }

  @override
  Future<void> updateAttendance(
      AttendanceModel attendance,
      ) {
    return _dataSource.updateAttendance(
      attendance,
    );
  }
}