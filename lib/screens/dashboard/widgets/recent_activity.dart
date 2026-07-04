import 'package:flutter/material.dart';

import '../../../widgets/cards/glass_card.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      "Rahul Kumar paid ₹1500",
      "New admission completed",
      "Protein purchased",
      "Attendance marked",
      "Gloves sold",
    ];

    return GlassCard(
      child: ListView.separated(
        itemCount: activities.length,
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
        const Divider(height: 20),
        itemBuilder: (_, index) {
          return ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 18,
              child: Icon(
                Icons.check,
                size: 18,
              ),
            ),
            title: Text(
              activities[index],
            ),
          );
        },
      ),
    );
  }
}