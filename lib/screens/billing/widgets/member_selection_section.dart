import 'package:flutter/material.dart';
import '../../../models/member_model.dart';

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
        TextFormField(
          controller: memberController,
          readOnly: true,
          onTap: onTap,
          decoration: const InputDecoration(
            labelText: 'Select Member',
            hintText: 'Tap to select member',
            prefixIcon: Icon(Icons.person_search),
            suffixIcon: Icon(Icons.search),
          ),
        ),

        if (selectedMember != null) ...[
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member ID : ${selectedMember!.memberId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedMember!.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

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