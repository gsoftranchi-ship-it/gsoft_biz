import 'package:flutter/material.dart';

import '../controllers/member_form_controller.dart';

class ContactInformationCard extends StatelessWidget {
  const ContactInformationCard({
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
              "Contact Information",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: controller.mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Mobile Number *",
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Mobile number is required";
                }

                if (value.length != 10) {
                  return "Enter valid mobile number";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.alternateMobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: const InputDecoration(
                labelText: "Alternate Mobile",
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }

                final emailRegex = RegExp(
                  r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                );

                if (!emailRegex.hasMatch(value)) {
                  return "Enter valid email";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: controller.addressController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Address",
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