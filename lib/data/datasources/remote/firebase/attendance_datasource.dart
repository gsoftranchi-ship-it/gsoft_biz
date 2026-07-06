import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/attendance_model.dart';

class AttendanceDataSource {
  AttendanceDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore =
      firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  final String _collection = 'attendance';

  Future<List<AttendanceModel>> loadAttendance({
    required String gymId,
  }) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('gymId', isEqualTo: gymId)
        .get();

    return snapshot.docs
        .map(
          (doc) => AttendanceModel.fromMap(
        doc.data(),
        doc.id,
      ),
    )
        .toList();
  }

  Future<void> markAttendance(
      AttendanceModel attendance,
      ) async {
    await _firestore
        .collection(_collection)
        .doc(attendance.attendanceId)
        .set(attendance.toMap());
  }

  Future<void> updateAttendance(
      AttendanceModel attendance,
      ) async {
    await _firestore
        .collection(_collection)
        .doc(attendance.attendanceId)
        .update(attendance.toMap());
  }
}