import 'package:flutter/material.dart';

class DocumentActionsCard extends StatelessWidget {
  const DocumentActionsCard({
    super.key,
    this.onUpload,
    this.onReplace,
    this.onDelete,
    this.onDownloadAll,
    this.onShare,
  });

  final VoidCallback? onUpload;
  final VoidCallback? onReplace;
  final VoidCallback? onDelete;
  final VoidCallback? onDownloadAll;
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
              'Document Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: onUpload,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload'),
                ),
                FilledButton.icon(
                  onPressed: onReplace,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Replace'),
                ),
                FilledButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
                FilledButton.icon(
                  onPressed: onDownloadAll,
                  icon: const Icon(Icons.download),
                  label: const Text('Download All'),
                ),
                FilledButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}