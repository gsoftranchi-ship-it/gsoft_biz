import 'package:flutter/material.dart';

import '../controllers/member_form_controller.dart';

class BasicInformationCard extends StatelessWidget {
  const BasicInformationCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Basic Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.memberIdController,
              enabled: false,
              decoration: const InputDecoration(
                labelText: "Member ID",
                prefixIcon: Icon(Icons.badge),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.fullNameController,
              decoration: const InputDecoration(
                labelText: "Full Name *",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Full Name is required";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(
                  child: TextFormField(
                    controller: controller.ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      prefixIcon: Icon(Icons.cake),
                    ),
                    onChanged: (value) {
                      final age = int.tryParse(value);

                      if (age != null) {
                        controller.updateAge(age);
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: TextFormField(
                    controller: controller.dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Date of Birth",
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {

                      final picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1940),
                        lastDate: DateTime.now(),
                        initialDate:
                        controller.dateOfBirth ??
                            DateTime(2000),
                      );

                      if (picked != null) {
                        controller.updateDob(picked);
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: controller.gender,
              decoration: const InputDecoration(
                labelText: "Gender",
                prefixIcon: Icon(Icons.people),
              ),
              items: const [

                DropdownMenuItem(
                  value: "Male",
                  child: Text("Male"),
                ),

                DropdownMenuItem(
                  value: "Female",
                  child: Text("Female"),
                ),

                DropdownMenuItem(
                  value: "Other",
                  child: Text("Other"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.setGender(value);
                }
              },

            ),

            const SizedBox(height: 16),

            SwitchListTile(
              value: controller.isActive,
              title: const Text("Active Member"),
              onChanged: controller.setMemberStatus,
            ),
          ],
        ),
      ),
    );
  }
}