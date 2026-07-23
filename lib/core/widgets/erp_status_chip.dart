import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

enum ERPStatus {
  active,
  inactive,
  pending,
  paid,
  unpaid,
  partial,
  cancelled,
  expired,
  overdue,
  completed,
  draft,
}

class ERPStatusChip extends StatelessWidget {
  final ERPStatus status;
  final String? label;

  const ERPStatusChip({
    super.key,
    required this.status,
    this.label,
  });

  Color get background {
    switch (status) {
      case ERPStatus.active:
      case ERPStatus.paid:
      case ERPStatus.completed:
        return AppColors.success.withValues(alpha: 0.15);

      case ERPStatus.pending:
      case ERPStatus.partial:
      case ERPStatus.draft:
        return AppColors.warning.withValues(alpha: 0.15);

      case ERPStatus.inactive:
      case ERPStatus.unpaid:
      case ERPStatus.cancelled:
      case ERPStatus.expired:
      case ERPStatus.overdue:
        return AppColors.danger.withValues(alpha: 0.15);
    }
  }

  Color get foreground {
    switch (status) {
      case ERPStatus.active:
      case ERPStatus.paid:
      case ERPStatus.completed:
        return AppColors.success;

      case ERPStatus.pending:
      case ERPStatus.partial:
      case ERPStatus.draft:
        return AppColors.warning;

      case ERPStatus.inactive:
      case ERPStatus.unpaid:
      case ERPStatus.cancelled:
      case ERPStatus.expired:
      case ERPStatus.overdue:
        return AppColors.danger;
    }
  }

  String get text {
    if (label != null) return label!;

    return switch (status) {
      ERPStatus.active => 'Active',
      ERPStatus.inactive => 'Inactive',
      ERPStatus.pending => 'Pending',
      ERPStatus.paid => 'Paid',
      ERPStatus.unpaid => 'Unpaid',
      ERPStatus.partial => 'Partial',
      ERPStatus.cancelled => 'Cancelled',
      ERPStatus.expired => 'Expired',
      ERPStatus.overdue => 'Overdue',
      ERPStatus.completed => 'Completed',
      ERPStatus.draft => 'Draft',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        text,
        style: AppTypography.caption.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}