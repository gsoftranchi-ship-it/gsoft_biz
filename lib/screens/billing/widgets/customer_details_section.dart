import 'package:flutter/material.dart';
import '../../../core/widgets/erp_text_field.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_typography.dart';

class CustomerDetailsSection extends StatelessWidget {
  const CustomerDetailsSection({
    super.key,
    required this.customerType,
    required this.customerController,
    required this.phoneController,
    required this.emailController,
    required this.addressController,
    required this.gstinController,
  });

  final String customerType;

  final TextEditingController customerController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController gstinController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (customerType == 'GUEST') ...[
          ERPTextField(
            controller: customerController,
            label: 'Customer Name',
            prefixIcon: const Icon(Icons.person),
          ),

          const SizedBox(height: AppSpacing.md),
        ],

        if (customerType == 'GUEST') ...[
          const Text(
            'Customer Information',
            style: AppTypography.cardTitle,
          ),

          const SizedBox(height: AppSpacing.md),
        ],

        ERPTextField(
          controller: phoneController,
          label: 'Phone',
          readOnly: customerType == 'MEMBER',
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone),
        ),

        const SizedBox(height: AppSpacing.md),

        ERPTextField(
          controller: emailController,
          label: 'Email',
          readOnly: customerType == 'MEMBER',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email),
        ),

        const SizedBox(height: 16),

        ERPTextField(
          controller: addressController,
          label: 'Address',
          readOnly: customerType == 'MEMBER',
          maxLines: 2,
          prefixIcon: const Icon(Icons.location_on),
        ),

        const SizedBox(height: 16),

        ERPTextField(
          controller: gstinController,
          label: 'GSTIN (Optional)',
          readOnly: customerType == 'MEMBER',
          prefixIcon: const Icon(Icons.badge),
        ),
      ],
    );
  }
}