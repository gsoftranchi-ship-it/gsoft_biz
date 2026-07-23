import 'package:flutter/material.dart';

class BillingHeader extends StatelessWidget {
  const BillingHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onPreview,
    this.onDownload,
    this.onPrint,
    this.onShare,
  });

  final String title;
  final String? subtitle;

  final VoidCallback? onPreview;
  final VoidCallback? onDownload;
  final VoidCallback? onPrint;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: onPreview,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview'),
              ),
              OutlinedButton.icon(
                onPressed: onDownload,
                icon: const Icon(Icons.download_outlined),
                label: const Text('Download'),
              ),
              OutlinedButton.icon(
                onPressed: onPrint,
                icon: const Icon(Icons.print_outlined),
                label: const Text('Print'),
              ),
              FilledButton.icon(
                onPressed: onShare,
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}