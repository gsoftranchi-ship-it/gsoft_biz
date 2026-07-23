import 'package:flutter/material.dart';
import '../../../models/member_model.dart';
import '../../../core/widgets/erp_text_field.dart';
import '../../../core/widgets/erp_card.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/constants/app_colors.dart';

class MemberSelectionSection extends StatelessWidget {
  const MemberSelectionSection({
    super.key,
    required this.memberController,
    required this.selectedMember,
    required this.onTap,
  });

  final TextEditingController memberController;
  final MemberModel? selectedMember;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ERPTextField(
          controller: memberController,
          label: 'Select Member',
          hint: 'Tap to select member',
          readOnly: true,
          onTap: onTap,
          prefixIcon: const Icon(Icons.person_search),
          suffixIcon: const Icon(Icons.search),
        ),

        if (selectedMember != null) ...[
          const SizedBox(height: AppSpacing.md),

          ERPCard(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member ID : ${selectedMember!.memberId}',
                    style: AppTypography.label.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    selectedMember!.fullName,
                    style: AppTypography.bodyLarge,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  Text('Phone : ${selectedMember!.phone}'),

                  Text('Email : ${selectedMember!.email}'),

                  Text('Address : ${selectedMember!.address}'),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}