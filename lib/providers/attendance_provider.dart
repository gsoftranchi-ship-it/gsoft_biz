import 'package:flutter/foundation.dart';
import '../data/repositories/impl/attendance_repository_impl.dart';
import '../models/attendance_model.dart';
import '../models/member_model.dart';
import '../models/base/audit_info.dart';
import '../models/base/entity_status.dart';
import '../models/base/tenant_info.dart';
import '../core/utils/id_generator.dart';

class AttendanceProvider extends ChangeNotifier {
  AttendanceProvider({
    AttendanceRepositoryImpl? repository,
  }) : _repository =
      repository ??
          AttendanceRepositoryImpl();

  final AttendanceRepositoryImpl _repository;

  bool _loading = false;

  String? _error;

  final List<AttendanceModel> _attendance = [];

  bool get loading => _loading;

  String? get error => _error;

  List<AttendanceModel> get attendance =>
      List.unmodifiable(_attendance);
  Future<void> loadAttendance({
    required String gymId,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final attendance = await _repository.loadAttendance(
        gymId: gymId,
      );

      _attendance
        ..clear()
        ..addAll(attendance);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  Future<void> markAttendanceForMember({
    required MemberModel member,
    required String currentUserId,
    required String gymId,
  }) async {
    final today = DateTime.now();

    final alreadyMarked = _attendance.any((record) {
      return record.memberId == member.memberId &&
          record.attendanceDate.year == today.year &&
          record.attendanceDate.month == today.month &&
          record.attendanceDate.day == today.day;
    });

    if (alreadyMarked) {
      throw Exception(
        'Attendance already marked for today.',
      );
    }

    final now = DateTime.now();

    final attendanceId =
    await IdGenerator.newAttendanceId(); // Use your project's existing ID generator
    final attendance = AttendanceModel(
      attendanceId: attendanceId,
      memberId: member.memberId,
      attendanceDate: now,
      checkInTime: now,
      checkOutTime: null,
      isPresent: true,
      remarks: '',
      tenantInfo: TenantInfo(
        gymId: gymId,
      ),
      auditInfo: AuditInfo(
        createdAt: now,
        updatedAt: now,
        createdBy: currentUserId,
        updatedBy: currentUserId,
      ),
      status: EntityStatus.active,
    );

    await _repository.markAttendance(attendance);

    await loadAttendance(
      gymId: gymId,
    );



  }
}
