import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../models/gym_model.dart';
import '../../models/base/audit_info.dart';
import '../../models/base/entity_status.dart';
import '../../models/base/tenant_info.dart';
import '../../providers/auth_provider.dart';

class GymProfilePage extends StatefulWidget {
  const GymProfilePage({super.key});

  @override
  State<GymProfilePage> createState() => _GymProfilePageState();
}

class _GymProfilePageState extends State<GymProfilePage> {
  final _formKey = GlobalKey<FormState>();

  //=========================================================
  // Partner Information
  //=========================================================

  final _partnerIdController = TextEditingController();

  final _gymNameController = TextEditingController();

  final _ownerNameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  final _websiteController = TextEditingController();

  //=========================================================
  // Business Information
  //=========================================================

  final _gstController = TextEditingController();

  final _registrationController = TextEditingController();

  final _businessTypeController = TextEditingController();

  final _currencyController = TextEditingController();

  final _timezoneController = TextEditingController();

  //=========================================================
  // Address
  //=========================================================

  final _addressController = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _countryController = TextEditingController();

  final _pincodeController = TextEditingController();

  @override
  void dispose() {
    _partnerIdController.dispose();

    _gymNameController.dispose();

    _ownerNameController.dispose();

    _phoneController.dispose();

    _emailController.dispose();

    _websiteController.dispose();

    _gstController.dispose();

    _registrationController.dispose();

    _businessTypeController.dispose();

    _currencyController.dispose();

    _timezoneController.dispose();

    _addressController.dispose();

    _cityController.dispose();

    _stateController.dispose();

    _countryController.dispose();

    _pincodeController.dispose();

    super.dispose();
  }
  bool _initialized = false;

  void _loadGymData(GymModel gym) {
    _partnerIdController.text = gym.gymCode;

    _gymNameController.text = gym.gymName;

    _ownerNameController.text = gym.ownerName;

    _phoneController.text = gym.phone ?? "";

    _emailController.text = gym.email ?? "";

    _websiteController.text = gym.website ?? "";

    _gstController.text = gym.gstNumber ?? "";

    _registrationController.text =
        gym.registrationNumber ?? "";

    _businessTypeController.text =
        gym.businessType ?? "";

    _currencyController.text = gym.currency;

    _timezoneController.text = gym.timezone;

    _addressController.text = gym.address ?? "";

    _cityController.text = gym.city ?? "";

    _stateController.text = gym.state ?? "";

    _countryController.text = gym.country ?? "";

    _pincodeController.text = gym.pincode ?? "";
  }


  InputDecoration decoration(
      String label,
      IconData icon,
      ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 14,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider =
    context.watch<DashboardProvider>();

    final authProvider =
    context.read<AuthProvider>();

    final GymModel? gym =
        dashboardProvider.gym;

    if (!_initialized) {
      _initialized = true;

      if (gym != null) {
        _loadGymData(gym);
      } else {
        _partnerIdController.text =
            authProvider.currentUser?.tenantInfo.gymId ?? "";

        _currencyController.text = "INR";

        _timezoneController.text = "Asia/Kolkata";
      }
    }
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,

      appBar: AppBar(
        title: const Text("Gym Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [

              const CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage(
                  'assets/images/logo.png',
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () {
                  // Part-7
                },
                icon: const Icon(Icons.photo_camera),
                label: const Text("Change Logo"),
              ),

              sectionTitle("Partner Information"),

              TextFormField(
                controller: _partnerIdController,
                readOnly: true,
                decoration: decoration(
                  "Partner ID",
                  Icons.badge_outlined,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _gymNameController,
                decoration: decoration(
                  "Gym Name",
                  Icons.fitness_center,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Gym Name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _ownerNameController,
                decoration: decoration(
                  "Owner Name",
                  Icons.person,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Owner Name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: decoration(
                  "Mobile Number",
                  Icons.phone,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration(
                  "Email Address",
                  Icons.email_outlined,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _websiteController,
                keyboardType: TextInputType.url,
                decoration: decoration(
                  "Website",
                  Icons.language,
                ),
              ),

              sectionTitle("Business Information"),

              TextFormField(
                controller: _gstController,
                decoration: decoration(
                  "GST Number",
                  Icons.receipt_long,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _registrationController,
                decoration: decoration(
                  "Registration Number",
                  Icons.assignment,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _businessTypeController,
                decoration: decoration(
                  "Business Type",
                  Icons.business_center,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _currencyController,
                decoration: decoration(
                  "Currency",
                  Icons.currency_rupee,
                ),
                readOnly: true,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _timezoneController,
                decoration: decoration(
                  "Timezone",
                  Icons.access_time,
                ),
                readOnly: true,
              ),

              sectionTitle("Address"),

              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: decoration(
                  "Address",
                  Icons.home_outlined,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _cityController,
                decoration: decoration(
                  "City",
                  Icons.location_city,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _stateController,
                decoration: decoration(
                  "State",
                  Icons.map_outlined,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _countryController,
                decoration: decoration(
                  "Country",
                  Icons.public,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                decoration: decoration(
                  "Pincode",
                  Icons.pin_drop_outlined,
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

                    final dashboardProvider =
                    context.read<DashboardProvider>();

                    final existingGym = dashboardProvider.gym;

                    final gym = GymModel(
                      id: _partnerIdController.text.trim(),

                      gymCode: _partnerIdController.text.trim(),

                      gymName: _gymNameController.text.trim(),

                      ownerName: _ownerNameController.text.trim(),

                      email: _emailController.text.trim().isEmpty
                          ? null
                          : _emailController.text.trim(),

                      phone: _phoneController.text.trim().isEmpty
                          ? null
                          : _phoneController.text.trim(),

                      address: _addressController.text.trim().isEmpty
                          ? null
                          : _addressController.text.trim(),

                      city: _cityController.text.trim().isEmpty
                          ? null
                          : _cityController.text.trim(),

                      state: _stateController.text.trim().isEmpty
                          ? null
                          : _stateController.text.trim(),

                      country: _countryController.text.trim().isEmpty
                          ? null
                          : _countryController.text.trim(),

                      pincode: _pincodeController.text.trim().isEmpty
                          ? null
                          : _pincodeController.text.trim(),

                      logoUrl: existingGym?.logoUrl,

                      gstNumber: _gstController.text.trim().isEmpty
                          ? null
                          : _gstController.text.trim(),

                      website: _websiteController.text.trim().isEmpty
                          ? null
                          : _websiteController.text.trim(),

                      registrationNumber:
                      _registrationController.text.trim().isEmpty
                          ? null
                          : _registrationController.text.trim(),

                      subscriptionPlan:
                      existingGym?.subscriptionPlan,

                      subscriptionStatus:
                      existingGym?.subscriptionStatus,

                      branchCount:
                      existingGym?.branchCount ?? 1,

                      businessType:
                      _businessTypeController.text.trim().isEmpty
                          ? null
                          : _businessTypeController.text.trim(),

                      supportContact:
                      existingGym?.supportContact,

                      subscriptionExpiry:
                      existingGym?.subscriptionExpiry,

                      currency:
                      _currencyController.text.trim(),

                      timezone:
                      _timezoneController.text.trim(),

                      isActive: true,

                      tenantInfo: TenantInfo(
                        gymId: _partnerIdController.text.trim(),
                      ),

                      auditInfo: AuditInfo(
                        createdAt:
                        existingGym?.auditInfo.createdAt ??
                            DateTime.now(),

                        updatedAt: DateTime.now(),

                        createdBy:
                        existingGym?.auditInfo.createdBy ??
                            "SYSTEM",

                        updatedBy: "SYSTEM",
                      ),

                      status: EntityStatus.active,
                    );


                    final messenger = ScaffoldMessenger.of(context);

                    debugPrint("Saving Gym : ${gym.toMap()}");

                    final success =
                    await dashboardProvider.saveGym(gym);

                    debugPrint("Save Result : $success");

                    if (!mounted) return;

                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? "Gym Profile Saved Successfully"
                              : "Unable to Save Gym Profile",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "Save Profile",
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}