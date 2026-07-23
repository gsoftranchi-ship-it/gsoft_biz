import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/widgets/erp_card.dart';

class BillingStatisticsSection extends StatelessWidget {
  const BillingStatisticsSection({
    super.key,
    required this.totalInvoices,
    required this.totalCollected,
    required this.totalOutstanding,
  });

  final int totalInvoices;
  final double totalCollected;
  final double totalOutstanding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _StatisticCard(
                  icon: Icons.receipt_long,
                  color: Colors.orange,
                  title: 'Invoices',
                  value: '$totalInvoices',
                ),
              ),

              const SizedBox(width: AppSpacing.lg),

              Expanded(
                child: _StatisticCard(
                  icon: Icons.currency_rupee,
                  color: Colors.green,
                  title: 'Collected',
                  value: '₹${totalCollected.toStringAsFixed(0)}',
                ),
              ),

              const SizedBox(width: AppSpacing.lg),

              Expanded(
                child: _StatisticCard(
                  icon: Icons.pending_actions,
                  color: Colors.redAccent,
                  title: 'Outstanding',
                  value: '₹${totalOutstanding.toStringAsFixed(0)}',
                ),
              ),
            ],
          );
        }

        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: [
            _StatisticCard(
              icon: Icons.receipt_long,
              color: Colors.orange,
              title: 'Invoices',
              value: '$totalInvoices',
            ),
            _StatisticCard(
              icon: Icons.currency_rupee,
              color: Colors.green,
              title: 'Collected',
              value: '₹${totalCollected.toStringAsFixed(0)}',
            ),
            _StatisticCard(
              icon: Icons.pending_actions,
              color: Colors.redAccent,
              title: 'Outstanding',
              value: '₹${totalOutstanding.toStringAsFixed(0)}',
            ),
          ],
        );
      },
    );
  }
}

class _StatisticCard extends StatelessWidget {
  const _StatisticCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ERPCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 34,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                title,
                style: AppTypography.cardSubtitle,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                value,
                style: AppTypography.displayMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}