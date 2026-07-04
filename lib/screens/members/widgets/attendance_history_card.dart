import 'package:flutter/material.dart';

class AttendanceHistoryCard extends StatelessWidget {
  const AttendanceHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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

            _tile("Today", "07:15 AM", true),
            _tile("Yesterday", "07:32 AM", true),
            _tile("02 Jul 2026", "-", false),
            _tile("01 Jul 2026", "06:58 AM", true),
            _tile("30 Jun 2026", "07:08 AM", true),
          ],
        ),
      ),
    );
  }

  Widget _tile(
      String date,
      String time,
      bool present,
      ) {
    return ListTile(
      dense: true,
      leading: Icon(
        present
            ? Icons.check_circle
            : Icons.cancel,
        color: present
            ? Colors.green
            : Colors.red,
      ),
      title: Text(date),
      subtitle: Text(
        present ? "Check-in : $time" : "Absent",
      ),
    );
  }
}