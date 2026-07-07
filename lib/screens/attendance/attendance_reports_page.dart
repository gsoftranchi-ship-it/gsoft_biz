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
    final presentCount =
        attendance.where((e) => e.isPresent).length;

    final absentCount =
        attendance.length - presentCount;

    final attendancePercent =
    attendance.isEmpty
        ? 0.0
        : (presentCount / attendance.length) * 100;

    final groupedAttendance =
    <DateTime, int>{};

    for (final record in attendance) {
      final date = DateTime(
        record.attendanceDate.year,
        record.attendanceDate.month,
        record.attendanceDate.day,
      );

      groupedAttendance.update(
        date,
            (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    final averageDailyAttendance =
    groupedAttendance.isEmpty
        ? 0.0
        : attendance.length /
        groupedAttendance.length;

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  'Present',
                  presentCount.toString(),
                  Colors.green,
                  Icons.check_circle,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  'Absent',
                  absentCount.toString(),
                  Colors.red,
                  Icons.cancel,
                ),
              ),

            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [

              Expanded(
                child: _summaryCard(
                  'Attendance',
                  '${attendancePercent.toStringAsFixed(1)}%',
                  Colors.blue,
                  Icons.pie_chart,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _summaryCard(
                  'Average',
                  averageDailyAttendance
                      .toStringAsFixed(1),
                  Colors.orange,
                  Icons.bar_chart,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
  Widget _summaryCard(
      String title,
      String value,
      Color color,
      IconData icon,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            CircleAvatar(
              backgroundColor:
              color.withValues(alpha: .15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),

            const SizedBox(height: 6),

            Text(title),

          ],
        ),
      ),
    );
  }
}