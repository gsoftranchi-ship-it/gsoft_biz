import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/member_model.dart';
import '../../../models/membership_invoice_model.dart';
import '../../../providers/member_provider.dart';
import '../../../providers/membership_provider.dart';

import '../../fees/membership_invoice_details_page.dart';
import '../../../core/widgets/erp_card.dart';
import '../../../core/widgets/erp_status_chip.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';

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
      return const ERPCard(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
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
      return const ERPCard(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: Text(
              'No recent billing activity.',
            ),
          ),
        ),
      );
    }

    return ERPCard(
      child: ListView.separated(
        shrinkWrap: true,
        physics:
        const NeverScrollableScrollPhysics(),
        itemCount: recentInvoices.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.sm,
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
                    ? AppColors.success.withValues(alpha: .15)
                    : AppColors.warning.withValues(alpha: .15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                invoice.dueAmount <= 0
                    ? Icons.payments_rounded
                    : Icons.pending_actions_rounded,
                color: invoice.dueAmount <= 0
                    ? AppColors.success
                    : AppColors.warning,
                size: 22,
              ),
            ),
            title: Text(
              member?.fullName ?? invoice.memberId,
              style: AppTypography.cardTitle.copyWith(
                fontSize: 15,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  invoice.invoiceNumber,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  invoice.invoiceDate
                      .toLocal()
                      .toString()
                      .split(' ')
                      .first,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
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
                ERPStatusChip(
                  status: invoice.dueAmount <= 0
                      ? ERPStatus.completed
                      : ERPStatus.pending,
                  label: status,
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