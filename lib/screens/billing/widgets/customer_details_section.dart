import 'package:flutter/material.dart';

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
          TextFormField(
            controller: customerController,
            decoration: const InputDecoration(
              labelText: 'Customer Name',
              prefixIcon: Icon(Icons.person),
            ),
          ),

          const SizedBox(height: 16),
        ],

        if (customerType == 'GUEST') ...[
          const Text(
            'Customer Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),
        ],

        TextFormField(
          controller: phoneController,
          readOnly: customerType == 'MEMBER',
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone',
            prefixIcon: Icon(Icons.phone),
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: emailController,
          readOnly: customerType == 'MEMBER',
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: addressController,
          readOnly: customerType == 'MEMBER',
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Address',
            prefixIcon: Icon(Icons.location_on),
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: gstinController,
          readOnly: customerType == 'MEMBER',
          decoration: const InputDecoration(
            labelText: 'GSTIN (Optional)',
            prefixIcon: Icon(Icons.badge),
          ),
        ),
      ],
    );
  }
}