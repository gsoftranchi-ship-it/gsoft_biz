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

    final members =
        memberProvider.members;

    final presentCount =
        attendance.where((e) => e.isPresent).length;

    final absentCount =
        attendance.length - presentCount;

    final attendancePercent =
    attendance.isEmpty
        ? 0.0
        : (presentCount / attendance.length) * 100;

    final lastAttendance =
    attendance.isEmpty
        ? null
        : attendance.first;

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
                  'Last',
                  lastAttendance == null
                      ? '--'
                      : lastAttendance.attendanceDate
                      .toString()
                      .split(' ')
                      .first,
                  Colors.orange,
                  Icons.history,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Member',
              border: OutlineInputBorder(),
            ),
            items: members
                .map(
                  (member) => DropdownMenuItem(
                value: member.memberId,
                child: Text(member.fullName),
              ),
            )
                .toList(),
            onChanged: (_) {},
          ),

          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Month',
              border: OutlineInputBorder(),
            ),
            initialValue: 'Current Month',
            items: const [

              DropdownMenuItem(
                value: 'Current Month',
                child: Text('Current Month'),
              ),

              DropdownMenuItem(
                value: 'Previous Month',
                child: Text('Previous Month'),
              ),
            ],
            onChanged: (_) {},
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
