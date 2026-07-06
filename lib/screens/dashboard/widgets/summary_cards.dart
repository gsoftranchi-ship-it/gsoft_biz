import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/member_provider.dart';
import '../../../providers/membership_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../widgets/cards/dashboard_card.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final memberProvider =
    context.watch<MemberProvider>();

    final membershipProvider =
    context.watch<MembershipProvider>();

    if (memberProvider.loading ||
        membershipProvider.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final activeMembers =
        memberProvider.activeMembers;

    final dueMembers =
        membershipProvider.invoices
            .where((e) => e.dueAmount > 0)
            .length;

    final outstandingRevenue =
    membershipProvider.invoices.fold<double>(
      0,
          (sum, invoice) => sum + invoice.dueAmount,
    );

    final today = DateTime.now();

    final todaysCollections =
    membershipProvider.payments
        .where((payment) {
      final date = payment.paymentDate;

      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    })
        .fold<double>(
      0,
          (sum, payment) =>
      sum + payment.amount,
    );

    int crossAxisCount;
    double childAspectRatio;

    if (width >= 1200) {
      crossAxisCount = 4;
      childAspectRatio = 1.35;
    } else if (width >= 900) {
      crossAxisCount = 4;
      childAspectRatio = 1.20;
    } else if (width >= 700) {
      crossAxisCount = 3;
      childAspectRatio = 1.05;
    } else if (width >= 500) {
      crossAxisCount = 2;
      childAspectRatio = 1.00;
    } else if (width >= 380) {
      crossAxisCount = 2;
      childAspectRatio = 0.82;
    } else {
      crossAxisCount = 1;
      childAspectRatio = 2.1;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return DashboardCard(
              icon: AppIcons.members,
              title: "Active Members",
              value: activeMembers.toString(),
              subtitle: "Current",
              color: AppColors.info,
            );

          case 1:
            return DashboardCard(
              icon: AppIcons.billing,
              title: "Due Members",
              value: dueMembers.toString(),
              subtitle: "Outstanding",
              color: AppColors.warning,
            );

          case 2:
            return DashboardCard(
              icon: AppIcons.billing,
              title: "Outstanding",
              value:
              "₹${outstandingRevenue.toStringAsFixed(2)}",
              subtitle: "Revenue",
              color: AppColors.primary,
            );

          default:
            return DashboardCard(
              icon: AppIcons.billing,
              title: "Today's Collection",
              value:
              "₹${todaysCollections.toStringAsFixed(2)}",
              subtitle: "Today",
              color: AppColors.success,
            );
        }
      },
    );
  }
}