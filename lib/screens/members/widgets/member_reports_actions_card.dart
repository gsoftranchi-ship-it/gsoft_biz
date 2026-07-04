import 'package:flutter/material.dart';

class MemberReportsActionsCard extends StatelessWidget {
  const MemberReportsActionsCard({
    super.key,
    this.onExportPdf,
    this.onPrint,
    this.onShare,
  });

  final VoidCallback? onExportPdf;
  final VoidCallback? onPrint;
  final VoidCallback? onShare;

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
              "Report Actions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: onExportPdf,
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Export PDF"),
                ),
                FilledButton.icon(
                  onPressed: onPrint,
                  icon: const Icon(Icons.print),
                  label: const Text("Print"),
                ),
                FilledButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}