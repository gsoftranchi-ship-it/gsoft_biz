import 'package:flutter/material.dart';

import '../../../../../core/constants/app_lists.dart';
import '../controllers/member_form_controller.dart';

class EmergencyContactCard extends StatelessWidget {
  const EmergencyContactCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Emergency Contact",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.emergencyNameController,
              decoration: const InputDecoration(
                labelText: "Contact Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: "Father",
              decoration: const InputDecoration(
                labelText: "Relationship",
                prefixIcon: Icon(Icons.family_restroom),
              ),
              items: AppLists.relationships
                  .map(
                    (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.emergencyRelationshipController.text =
                      value;
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.emergencyMobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Emergency Mobile",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.emergencyAddressController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Emergency Address",
                prefixIcon: Icon(Icons.location_on),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}