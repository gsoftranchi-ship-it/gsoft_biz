import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({super.key});

  @override
  State<AttendanceHistoryPage> createState() =>
      _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState
    extends State<AttendanceHistoryPage> {


  @override
  Widget build(BuildContext context) {
    final attendanceProvider =
    context.watch<AttendanceProvider>();

    final memberProvider =
    context.watch<MemberProvider>();

    if (attendanceProvider.loading ||
        memberProvider.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (attendanceProvider.error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendance History',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              attendanceProvider.error!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }


    final attendance =
        attendanceProvider.attendance;

    /*final members =
        memberProvider.members;*/// We will add it back in Sprint 18C.2 when we actually use it for the member filter.
    if (attendance.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendance History',
          ),
        ),
        body: const Center(
          child: Text(
            'No attendance history available.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance History',
        ),
      ),
      body: const Center(
        child: Text(
          'Sprint 18C',
        ),
      ),
    );
  }
  }
