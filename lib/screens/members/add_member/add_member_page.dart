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
import 'package:provider/provider.dart';

import '../../../../providers/auth_provider.dart';
import '../../../../providers/member_provider.dart';
import '../../../../models/member_model.dart';

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

  Future<void> _saveMember() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final memberProvider = context.read<MemberProvider>();

    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User session expired."),
        ),
      );
      return;
    }

    final memberId = await memberProvider.generateNextMemberId();

    if (memberId == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            memberProvider.failure?.message ??
                "Unable to generate Member ID.",
          ),
        ),
      );
      return;
    }

    final MemberModel member = controller.buildMember(
      memberId: memberId,
      gymId: currentUser.tenantInfo.gymId,
    );

    final success = await memberProvider.add(member);



    if (!mounted) return;

    if (success) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Admission Completed"),
          content: Text(
            "${member.fullName}\n\nAdmission saved successfully.",
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            memberProvider.failure?.message ??
                "Unable to save member.",
          ),
        ),
      );
    }
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