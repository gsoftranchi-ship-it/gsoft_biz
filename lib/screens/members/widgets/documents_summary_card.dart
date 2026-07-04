import 'package:flutter/material.dart';

class DocumentsSummaryCard extends StatelessWidget {
  const DocumentsSummaryCard({
    super.key,
    required this.profilePhoto,
    required this.aadhaar,
    required this.pan,
    required this.medicalReport,
    required this.otherDocuments,
  });

  final bool profilePhoto;
  final bool aadhaar;
  final bool pan;
  final bool medicalReport;
  final int otherDocuments;

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
              'Documents Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _row('Profile Photo', profilePhoto),
            _row('Aadhaar', aadhaar),
            _row('PAN', pan),
            _row('Medical Report', medicalReport),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Other Documents'),
                  ),
                  Text(
                    '$otherDocuments File(s)',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, bool available) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            color: available ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }
}