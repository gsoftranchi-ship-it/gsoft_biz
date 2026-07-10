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
    // TODO(Sprint 18):
    // Show recent MembershipPaymentModel records first,
    // followed by recent invoices.

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
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 8,
          ),
          child: Divider(
            color: Colors.white.withValues(alpha: .06),
            height: 24,
          ),
        ),
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
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: invoice.dueAmount <= 0
                    ? Colors.green.withValues(alpha: .15)
                    : Colors.orange.withValues(alpha: .15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                invoice.dueAmount <= 0
                    ? Icons.payments_rounded
                    : Icons.pending_actions_rounded,
                color: invoice.dueAmount <= 0
                    ? Colors.green
                    : Colors.orange,
                size: 22,
              ),
            ),
            title: Text(
              member?.fullName ?? invoice.memberId,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  invoice.invoiceNumber,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                Text(
                  invoice.invoiceDate
                      .toLocal()
                      .toString()
                      .split(' ')
                      .first,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: invoice.dueAmount <= 0
                        ? Colors.green.withValues(alpha: .12)
                        : Colors.orange.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      color: invoice.dueAmount <= 0
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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