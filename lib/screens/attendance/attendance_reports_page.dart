import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/attendance_provider.dart';
import '../../providers/member_provider.dart';

class AttendanceReportsPage extends StatefulWidget {
  const AttendanceReportsPage({super.key});

  @override
  State<AttendanceReportsPage> createState() =>
      _AttendanceReportsPageState();
}

class _AttendanceReportsPageState
    extends State<AttendanceReportsPage> {

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
            'Attendance Reports',
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

    if (attendance.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendance Reports',
          ),
        ),
        body: const Center(
          child: Text(
            'No attendance reports available.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Reports',
        ),
      ),
      body: const Center(
        child: Text(
          'Sprint 18D',
        ),
      ),
    );
  }
    }