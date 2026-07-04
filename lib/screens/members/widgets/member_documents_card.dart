import 'package:flutter/material.dart';

class MemberDocumentsCard extends StatelessWidget {
  const MemberDocumentsCard({super.key});

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
              'Member Documents',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 24),

            _documentTile('Aadhaar.pdf'),
            _documentTile('PAN.pdf'),
            _documentTile('Medical_Report.pdf'),
          ],
        ),
      ),
    );
  }

  Widget _documentTile(String fileName) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        child: Icon(Icons.description),
      ),
      title: Text(fileName),
      trailing: Wrap(
        spacing: 8,
        children: [
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.visibility),
            tooltip: 'View',
          ),
          IconButton(
            onPressed: null,
            icon: const Icon(Icons.download),
            tooltip: 'Download',
          ),
        ],
      ),
    );
  }
}