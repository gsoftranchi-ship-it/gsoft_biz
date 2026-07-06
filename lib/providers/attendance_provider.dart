import 'package:flutter/foundation.dart';

import '../models/attendance_model.dart';

class AttendanceProvider extends ChangeNotifier {
  final bool _loading = false;

  final List<AttendanceModel> _attendance = [];

  bool get loading => _loading;

  List<AttendanceModel> get attendance =>
      List.unmodifiable(_attendance);
}