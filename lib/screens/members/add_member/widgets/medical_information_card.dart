import 'package:flutter/material.dart';

import '../../../../../core/constants/app_lists.dart';
import '../controllers/member_form_controller.dart';

class MedicalInformationCard extends StatelessWidget {
  const MedicalInformationCard({
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
              "Medical Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: null,
              decoration: const InputDecoration(
                labelText: "Blood Group",
                prefixIcon: Icon(Icons.bloodtype),
              ),
              items: AppLists.bloodGroups
                  .map(
                    (group) => DropdownMenuItem(
                  value: group,
                  child: Text(group),
                ),
              )
                  .toList(),
              onChanged: (value) {
                controller.bloodGroupController.text =
                    value ?? "";
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.diseaseController,
              decoration: const InputDecoration(
                labelText: "Existing Disease",
                prefixIcon: Icon(Icons.medical_information),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.allergyController,
              decoration: const InputDecoration(
                labelText: "Allergy",
                prefixIcon: Icon(Icons.warning_amber),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.medicationController,
              decoration: const InputDecoration(
                labelText: "Current Medication",
                prefixIcon: Icon(Icons.medication),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.surgeryController,
              decoration: const InputDecoration(
                labelText: "Previous Surgery",
                prefixIcon: Icon(Icons.local_hospital),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.doctorNameController,
              decoration: const InputDecoration(
                labelText: "Doctor Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.doctorMobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Doctor Mobile",
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.medicalRemarksController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Medical Remarks",
                prefixIcon: Icon(Icons.notes),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}