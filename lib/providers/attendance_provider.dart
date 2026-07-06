import 'package:flutter/foundation.dart';

import '../data/repositories/impl/attendance_repository_impl.dart';
import '../models/attendance_model.dart';

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
}
