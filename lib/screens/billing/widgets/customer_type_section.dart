import 'package:flutter/material.dart';
import '../../../core/widgets/erp_dropdown.dart';

class CustomerTypeSection extends StatelessWidget {
  const CustomerTypeSection({
    super.key,
    required this.customerType,
    required this.onChanged,
  });

  final String customerType;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ERPDropdown<String>(
      value: customerType,
      label: 'Customer Type',
      prefixIcon: const Icon(Icons.person_outline),
      items: const [
        DropdownMenuItem(
          value: 'MEMBER',
          child: Text('Gym Member'),
        ),
        DropdownMenuItem(
          value: 'GUEST',
          child: Text('Walk-In Customer'),
        ),
      ],
      onChanged: onChanged,
    );
  }
}