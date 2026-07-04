import 'package:flutter/material.dart';
import 'controllers/member_form_controller.dart';
import 'widgets/member_photo_card.dart';
import 'widgets/basic_information_card.dart';
import 'widgets/contact_information_card.dart';
import 'widgets/membership_information_card.dart';
import 'widgets/payment_information_card.dart';
import 'widgets/health_baseline_card.dart';
import 'widgets/emergency_contact_card.dart';
import 'widgets/medical_information_card.dart';
import 'widgets/documents_card.dart';
import 'widgets/save_member_button.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final _formKey = GlobalKey<FormState>();

  late final MemberFormController controller;

  @override
  void initState() {
    super.initState();

    controller = MemberFormController();

    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _saveMember() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Admission module completed.\nFirestore integration is next.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("New Member Admission"),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  MemberPhotoCard(
                    controller: controller,
                  ),

                  BasicInformationCard(
                    controller: controller,
                  ),

                  ContactInformationCard(
                    controller: controller,
                  ),

                  MembershipInformationCard(
                    controller: controller,
                  ),

                  PaymentInformationCard(
                    controller: controller,
                  ),

                  HealthBaselineCard(
                    controller: controller,
                  ),

                  EmergencyContactCard(
                    controller: controller,
                  ),

                  MedicalInformationCard(
                    controller: controller,
                  ),

                  const DocumentsCard(),

                  SaveMemberButton(
                    controller: controller,
                    onSave: _saveMember,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}