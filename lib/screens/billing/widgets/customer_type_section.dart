import 'package:flutter/material.dart';

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
    return DropdownButtonFormField<String>(
      initialValue: customerType,
      decoration: const InputDecoration(
        labelText: 'Customer Type',
        prefixIcon: Icon(Icons.person_outline),
      ),
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