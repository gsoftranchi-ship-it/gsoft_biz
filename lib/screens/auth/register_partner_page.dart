import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class RegisterPartnerPage extends StatefulWidget {
  const RegisterPartnerPage({super.key});

  @override
  State<RegisterPartnerPage> createState() => _RegisterPartnerPageState();
}

class _RegisterPartnerPageState extends State<RegisterPartnerPage> {
  final _formKey = GlobalKey<FormState>();

  final _gymNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _remarksController = TextEditingController();

  String _selectedPlan = 'Basic';
  String _branches = '1';

  @override
  void dispose() {
    _gymNameController.dispose();
    _ownerNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,

        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Material(
            color: const Color(0xFF2E8F3A),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.pop(context),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        title: const Text('Register Your Gym'),
        centerTitle: false,
      ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background/dashboard_surface.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff071B33).withValues(alpha: .72),
              ),
              child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Partner Registration',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Complete the form below. After verification, we will send your Partner ID and temporary password.',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _gymNameController,
                    decoration: decoration(
                      'Gym Name',
                      Icons.fitness_center,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Gym Name is required.';
                      }

                      if (value.trim().length < 3) {
                        return 'Gym Name must be at least 3 characters.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ownerNameController,
                    decoration: decoration(
                      'Owner Name',
                      Icons.person,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Owner Name is required.';
                      }

                      if (value.trim().length < 3) {
                        return 'Owner Name must be at least 3 characters.';
                      }

                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
                        return 'Only alphabets and spaces are allowed.';
                      }

                      return null;
                    },
                  ),


                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: decoration(
                      'Mobile Number',
                      Icons.phone,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Mobile Number is required.';
                      }

                      if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value.trim())) {
                        return 'Enter a valid 10-digit mobile number.';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email Address is required.';
                      }

                      final emailRegex = RegExp(
                        r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Enter a valid email address.';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: decoration(
                      'Email Address',
                      Icons.email_outlined,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _cityController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'City is required.';
                      }

                      return null;
                    },
                    decoration: decoration(
                      'City',
                      Icons.location_city,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _stateController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'State is required.';
                      }

                      return null;
                    },
                    decoration: decoration(
                      'State',
                      Icons.map,
                    ),
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    initialValue: _branches,
                    decoration: decoration(
                      'Number of Branches',
                      Icons.store,
                    ),
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('1')),
                      DropdownMenuItem(value: '2', child: Text('2')),
                      DropdownMenuItem(value: '3', child: Text('3')),
                      DropdownMenuItem(value: '5+', child: Text('5+')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _branches = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    initialValue: _selectedPlan,
                    decoration: decoration(
                      'Plan Interested',
                      Icons.workspace_premium,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Basic',
                        child: Text('Basic'),
                      ),
                      DropdownMenuItem(
                        value: 'Professional',
                        child: Text('Professional'),
                      ),
                      DropdownMenuItem(
                        value: 'Enterprise',
                        child: Text('Enterprise'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPlan = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _remarksController,
                    maxLines: 5,
                    decoration: decoration(
                      'Requirements / Remarks',
                      Icons.notes,
                    ),
                  ),

                  const SizedBox(height: 30),


                  SizedBox(
                    height: 55,
                    child: FilledButton.icon(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 50,
                              ),
                              title: const Text(
                                'Registration Submitted',
                                textAlign: TextAlign.center,
                              ),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Thank you for choosing GYM ERP.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Your registration request has been submitted successfully.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Our team will verify your information.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Once approved, your Partner ID and temporary password will be shared with you via WhatsApp.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Status: Pending Approval',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: [
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (!context.mounted) return;

                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Submit Registration Request',
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
            ),
        ),
    );
  }
}