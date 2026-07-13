import 'package:flutter/material.dart';
import '../../../models/attendance_model.dart';

class AttendanceHistoryCard extends StatelessWidget {
  final List<AttendanceModel> attendance;

  const AttendanceHistoryCard({
    super.key,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Attendance",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const Divider(height: 24),

            if (attendance.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text("No attendance available"),
                ),
              )
            else
              ...attendance.take(10).map((record) {
                final icon = record.isPresent
                    ? Icons.check_circle
                    : Icons.cancel;

                final color = record.isPresent
                    ? Colors.green
                    : Colors.red;

                final checkIn = record.checkInTime == null
                    ? "--"
                    : TimeOfDay.fromDateTime(
                  record.checkInTime!,
                ).format(context);

                return ListTile(
                  leading: Icon(
                    icon,
                    color: color,
                  ),
                  title: Text(
                    record.attendanceDate
                        .toString()
                        .split(' ')
                        .first,
                  ),
                  subtitle: Text(
                    "Check In : $checkIn",
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}