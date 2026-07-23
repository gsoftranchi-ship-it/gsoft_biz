import 'package:flutter/material.dart';

import '../../../models/invoice_render_data.dart';
import '../widgets/invoice_template.dart';

class InvoicePreviewPage extends StatelessWidget {
  final InvoiceRenderData data;

  const InvoicePreviewPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E7EB),
      appBar: AppBar(
        title: const Text('Invoice Preview'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              // RC4 PDF
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              // RC4 Print
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // RC4 Share
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: Card(
              elevation: 6,
              clipBehavior: Clip.antiAlias,
              child: InvoiceTemplate(
                data: data,
              ),
            ),
          ),
        ),
      ),
    );
  }
}