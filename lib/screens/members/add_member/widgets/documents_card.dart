import 'package:flutter/material.dart';

class DocumentsCard extends StatelessWidget {
  const DocumentsCard({super.key});

  Widget buildUploadTile({
    required IconData icon,
    required String title,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: const Text(
          "Upload will be enabled in next sprint",
        ),
        trailing: const Icon(Icons.upload_file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Text(
              "Documents",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            const SizedBox(height: 20),

            buildUploadTile(
              icon: Icons.badge,
              title: "Aadhaar Card",
            ),

            buildUploadTile(
              icon: Icons.credit_card,
              title: "PAN Card",
            ),

            buildUploadTile(
              icon: Icons.description,
              title: "Medical Report",
            ),

            buildUploadTile(
              icon: Icons.folder,
              title: "Other Documents",
            ),
          ],
        ),
      ),
    );
  }
}