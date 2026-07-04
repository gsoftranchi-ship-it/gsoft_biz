import 'package:flutter/material.dart';

class MedicalHistoryCard extends StatelessWidget {
  const MedicalHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              "Medical History",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            const Divider(height: 24),

            _item(
              Icons.favorite,
              "Blood Pressure",
              "Normal",
            ),

            _item(
              Icons.monitor_heart,
              "Heart Rate",
              "72 BPM",
            ),

            _item(
              Icons.water_drop,
              "Blood Sugar",
              "Normal",
            ),

            _item(
              Icons.medical_services,
              "Previous Injury",
              "None",
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
      IconData icon,
      String title,
      String value,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}