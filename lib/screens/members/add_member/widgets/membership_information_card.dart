import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/member_form_controller.dart';

class MembershipInformationCard extends StatelessWidget {
  const MembershipInformationCard({
    super.key,
    required this.controller,
  });

  final MemberFormController controller;

  Future<void> _pickJoiningDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.joiningDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      controller.setJoiningDate(picked);
    }
  }

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
              "Membership Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: controller.membershipPlan,
              decoration: const InputDecoration(
                labelText: "Membership Plan",
                prefixIcon: Icon(Icons.workspace_premium),
              ),
              items: const [

                DropdownMenuItem(
                  value: "Monthly",
                  child: Text("Monthly"),
                ),

                DropdownMenuItem(
                  value: "Quarterly",
                  child: Text("Quarterly"),
                ),

                DropdownMenuItem(
                  value: "Half Yearly",
                  child: Text("Half Yearly"),
                ),

                DropdownMenuItem(
                  value: "Yearly",
                  child: Text("Yearly"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.setMembershipPlan(value);
                }
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text("Admission Date"),
              subtitle: Text(
                DateFormat('dd MMM yyyy')
                    .format(controller.admissionDate),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: controller.admissionDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2050),
                );

                if (picked != null) {
                  controller.setAdmissionDate(picked);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Joining Date"),
              subtitle: Text(
                DateFormat('dd MMM yyyy')
                    .format(controller.joiningDate),
              ),
              trailing: const Icon(Icons.edit),
              onTap: () => _pickJoiningDate(context),
            ),

            if (controller.expiryDate != null)
              ListTile(
                leading: const Icon(Icons.event_available),
                title: const Text("Expiry Date"),
                subtitle: Text(
                  DateFormat('dd MMM yyyy')
                      .format(controller.expiryDate!),
                ),
              ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Assigned Trainer",
                prefixIcon: Icon(Icons.sports),
              ),
              initialValue: controller.assignedTrainer,
              onChanged: (value) {
                controller.assignedTrainer = value;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: controller.batch,
              decoration: const InputDecoration(
                labelText: "Batch",
                prefixIcon: Icon(Icons.schedule),
              ),
              items: const [

                DropdownMenuItem(
                  value: "Morning",
                  child: Text("Morning"),
                ),

                DropdownMenuItem(
                  value: "Evening",
                  child: Text("Evening"),
                ),

                DropdownMenuItem(
                  value: "Flexible",
                  child: Text("Flexible"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.batch = value;
                }
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: controller.admissionSource,
              decoration: const InputDecoration(
                labelText: "Admission Source",
                prefixIcon: Icon(Icons.campaign),
              ),
              items: const [

                DropdownMenuItem(
                  value: "Walk In",
                  child: Text("Walk In"),
                ),

                DropdownMenuItem(
                  value: "Referral",
                  child: Text("Referral"),
                ),

                DropdownMenuItem(
                  value: "Online",
                  child: Text("Online"),
                ),

                DropdownMenuItem(
                  value: "Social Media",
                  child: Text("Social Media"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.admissionSource = value;
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.remarksController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Remarks",
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