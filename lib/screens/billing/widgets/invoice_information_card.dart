import 'package:flutter/material.dart';
import '../../../core/widgets/erp_card.dart';
import '../../../core/widgets/erp_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';

class InvoiceInformationCard extends StatelessWidget {
  const InvoiceInformationCard({
    super.key,
    required this.invoiceNumberController,
    required this.invoiceDateController,

  });

  final TextEditingController invoiceNumberController;
  final TextEditingController invoiceDateController;


  @override
  Widget build(BuildContext context) {
    return ERPCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'STEP 1',
              style: AppTypography.label.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: AppSpacing.xs),

            const Text(
              'Customer & Invoice Information',
              style: AppTypography.pageTitle,
            ),

            const SizedBox(height: AppSpacing.sm),

            const Text(
              'Create and manage invoice details for members or walk-in customers.',
              style: AppTypography.bodySmall,
            ),

            const Divider(height: 28),

            Row(
              children: [

                Expanded(
                  child: ERPTextField(
                    controller: invoiceNumberController,
                    label: 'Invoice Number',
                    readOnly: true,
                  ),
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: ERPTextField(
                    controller: invoiceDateController,
                    label: 'Invoice Date',
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}