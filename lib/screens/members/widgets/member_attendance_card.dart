import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class MemberAttendanceCard extends StatelessWidget {
  const MemberAttendanceCard({
    super.key,
    required this.presentDays,
    required this.absentDays,
    required this.totalDays,
    required this.lastCheckIn,
  });

  final int presentDays;
  final int absentDays;
  final int totalDays;
  final String lastCheckIn;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(
              height: 24,
              color: AppColors.divider,
            ),

            _row('Present', '$presentDays Days'),
            _row('Absent', '$absentDays Days'),
            _row('Total Attendance', '$totalDays Days'),
            _row('Last Check-in', lastCheckIn),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}