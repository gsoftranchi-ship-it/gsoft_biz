import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/member_model.dart';
import '../../../models/membership_invoice_model.dart';
import '../../../providers/member_provider.dart';
import '../../../providers/membership_provider.dart';
import '../../../widgets/cards/glass_card.dart';
import '../../fees/membership_invoice_details_page.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final memberProvider =
    context.watch<MemberProvider>();

    final membershipProvider =
    context.watch<MembershipProvider>();

    if (memberProvider.loading ||
        membershipProvider.loading) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final members = memberProvider.members;

    final invoices =
    List<MembershipInvoiceModel>.from(
      membershipProvider.invoices,
    );

    invoices.sort(
          (a, b) =>
          b.invoiceDate.compareTo(a.invoiceDate),
    );

    final recentInvoices =
    invoices.take(5).toList();

    if (recentInvoices.isEmpty) {
      return const GlassCard(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'No recent billing activity.',
            ),
          ),
        ),
      );
    }

    return GlassCard(
      child: ListView.separated(
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        itemCount: recentInvoices.length,
        separatorBuilder: (context, index) =>
        const Divider(height: 20),
        itemBuilder: (context, index) {
          final invoice =
          recentInvoices[index];

          final MemberModel? member =
          members.cast<MemberModel?>().firstWhere(
                (m) =>
            m?.memberId ==
                invoice.memberId,
            orElse: () => null,
          );

          final status =
          invoice.dueAmount <= 0
              ? 'Payment Completed'
              : 'Outstanding Payment';

          return ListTile(
            dense: true,
            contentPadding:
            EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 18,
              child: Icon(
                invoice.dueAmount <= 0
                    ? Icons.check
                    : Icons.receipt_long,
                size: 18,
              ),
            ),
            title: Text(
              member?.fullName ??
                  invoice.memberId,
            ),
            subtitle: Text(
              '${invoice.invoiceNumber} • ${invoice.invoiceDate.toLocal().toString().split(' ').first}',
            ),
            trailing: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${invoice.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
                Text(status),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MembershipInvoiceDetailsPage(
                        invoice: invoice,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}