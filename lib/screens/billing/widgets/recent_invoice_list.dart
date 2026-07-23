import 'package:flutter/material.dart';

import '../../../models/invoice_model.dart';
import '../../../widgets/billing/invoice_card.dart';
import '../../../core/widgets/erp_loading.dart';
import '../../../core/widgets/erp_empty_state.dart';

class RecentInvoiceList extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final List<InvoiceModel> invoices;
  final ValueChanged<InvoiceModel> onInvoiceTap;

  const RecentInvoiceList({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.invoices,
    required this.onInvoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const ERPLoading(
        message: 'Loading invoices...',
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(errorMessage!),
      );
    }

    if (invoices.isEmpty) {
      return const ERPEmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'No invoices found',
        message: 'Create your first invoice to start billing.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 96,
      ),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];

        return InvoiceCard(
          invoice: invoice,
          onTap: () => onInvoiceTap(invoice),
        );
      },
    );
  }
}