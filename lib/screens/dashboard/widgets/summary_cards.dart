import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/member_provider.dart';
import '../../../providers/membership_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../widgets/cards/dashboard_card.dart';


class SummaryCards extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const SummaryCards({
    super.key,
    required this.onNavigate,
  });

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
          (sum, payment) => sum + payment.amount,
    );

    int crossAxisCount;

    final double cardHeight;

    if (width >= 1400) {
      crossAxisCount = 4;
      cardHeight = 180;
    } else if (width >= 1200) {
      crossAxisCount = 4;
      cardHeight = 170;
    } else if (width >= 900) {
      crossAxisCount = 3;
      cardHeight = 165;
    } else if (width >= 700) {
      crossAxisCount = 2;
      cardHeight = 160;
    } else if (width >= 500) {
      crossAxisCount = 2;
      cardHeight = 155;
    } else {
      crossAxisCount = 1;
      cardHeight = 150;
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: cardHeight,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return DashboardCard(
              onTap: () => onNavigate(1),
              icon: AppIcons.members,
              title: "Active Members",
              value: activeMembers.toString(),
              subtitle: "Active Members",
              color: AppColors.info,
            );

          case 1:
            return DashboardCard(
              onTap: () => onNavigate(3),
              icon: AppIcons.billing,
              title: "Due Members",
              value: dueMembers.toString(),
              subtitle: "Outstanding",
              color: AppColors.warning,
            );

          case 2:
            return DashboardCard(
              onTap: () => onNavigate(3),
              icon: AppIcons.billing,
              title: "Outstanding",
              value:
              "₹${outstandingRevenue.toStringAsFixed(2)}",
              subtitle: "Pending Collection",
              color: AppColors.primary,
            );

          default:
            return DashboardCard(
              onTap: () => onNavigate(5),
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