import 'package:flutter/material.dart';
import '../../../models/attendance_model.dart';

class AttendanceCalendarCard extends StatelessWidget {

  final List<AttendanceModel> attendance;

  const AttendanceCalendarCard({
    super.key,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final daysInMonth = DateUtils.getDaysInMonth(
      now.year,
      now.month,
    );

    final records = <int, AttendanceModel>{};

    for (final record in attendance) {
      if (record.attendanceDate.year == now.year &&
          record.attendanceDate.month == now.month) {
        records[record.attendanceDate.day] = record;
      }
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Attendance",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: daysInMonth,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, index) {
                final day = index + 1;

                final record = records[day];

                Color color;

                if (record == null) {
                  color = Colors.grey;
                } else if (record.isPresent) {
                  color = Colors.green;
                } else {
                  color = Colors.red;
                }

                return Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$day",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}