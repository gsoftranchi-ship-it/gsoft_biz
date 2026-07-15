import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/utils/age_calculator.dart';
import '../../../../core/utils/bmi_calculator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../models/member_model.dart';
import 'package:intl/intl.dart';


class MemberFormController extends ChangeNotifier {
  //==========================
  // BASIC INFORMATION
  //==========================

  final fullNameController = TextEditingController();

  final ageController = TextEditingController();

  final dobController = TextEditingController();

  final memberIdController = TextEditingController();

  String gender = "Male";

  bool isActive = true;

  DateTime? dateOfBirth;

  String photoUrl = "";

  XFile? selectedPhoto;


  //==========================
  // CONTACT
  //==========================
  final mobileController = TextEditingController();

  final alternateMobileController = TextEditingController();

  final emailController = TextEditingController();

  final addressController = TextEditingController();

  final cityController = TextEditingController();

  final stateController = TextEditingController();

  final pinCodeController = TextEditingController();

  final occupationController = TextEditingController();

  final emergencyContactNameController =
  TextEditingController();

  final emergencyContactNumberController =
  TextEditingController();

  //==========================
  // MEMBERSHIP
  //==========================

  DateTime admissionDate = DateTime.now();

  DateTime joiningDate = DateTime.now();

  DateTime? expiryDate;

  String membershipPlan = "Monthly";

  String assignedTrainer = "";

  String batch = "Morning";

  String membershipStatus = "Active";

  String admissionSource = "Walk In";

  final remarksController = TextEditingController();

  //==========================
  // PAYMENT
  //==========================

  final admissionFeeController = TextEditingController();

  final membershipFeeController = TextEditingController();

  final discountController = TextEditingController();

  final finalAmountController = TextEditingController();

  final paidAmountController = TextEditingController();

  final dueAmountController = TextEditingController();

  final transactionIdController = TextEditingController();

  final receiptNumberController = TextEditingController();

  final paymentRemarksController = TextEditingController();

  String paymentMode = "Cash";

  DateTime? nextDueDate;

  void calculateFinalAmount() {
    final admission =
        double.tryParse(admissionFeeController.text) ?? 0;

    final membership =
        double.tryParse(membershipFeeController.text) ?? 0;

    final discount =
        double.tryParse(discountController.text) ?? 0;

    final total =
        admission + membership - discount;

    finalAmountController.text =
        total.toStringAsFixed(2);

    calculateDue();

    notifyListeners();
  }
  //==========================
  // DUE AMOUNT
  //==========================
  void calculateDue() {
    final total =
        double.tryParse(finalAmountController.text) ?? 0;

    final paid =
        double.tryParse(paidAmountController.text) ?? 0;

    final due = total - paid;

    dueAmountController.text =
        due.toStringAsFixed(2);

    notifyListeners();
  }

  void setPaymentMode(String mode) {
    paymentMode = mode;
    notifyListeners();
  }

  //==========================
// HEALTH
//==========================

  final heightController = TextEditingController();

  final weightController = TextEditingController();

  final chestController = TextEditingController();

  final waistController = TextEditingController();

  final hipController = TextEditingController();

  final leftArmController = TextEditingController();

  final rightArmController = TextEditingController();

  final leftThighController = TextEditingController();

  final rightThighController = TextEditingController();

  final calfController = TextEditingController();

  final bloodPressureController = TextEditingController();

  final sugarController = TextEditingController();

  final heartRateController = TextEditingController();


  double bmi = 0;

  String bmiCategory = "";

  String bmiRemark = "";

  //==========================
// EMERGENCY
//==========================

  final emergencyNameController =
  TextEditingController();

  final emergencyRelationshipController =
  TextEditingController();

  final emergencyMobileController =
  TextEditingController();

  final emergencyAddressController =
  TextEditingController();


//==========================
// MEDICAL
//==========================

  final bloodGroupController =
  TextEditingController();

  final diseaseController =
  TextEditingController();

  final allergyController =
  TextEditingController();

  final medicationController =
  TextEditingController();

  final surgeryController =
  TextEditingController();

  final doctorNameController =
  TextEditingController();

  final doctorMobileController =
  TextEditingController();

  final medicalRemarksController =
  TextEditingController();


//==========================
// DOCUMENTS
//==========================

  final aadhaarNumberController =
  TextEditingController();

  final panNumberController =
  TextEditingController();

  String aadhaarDocumentUrl = "";

  String panDocumentUrl = "";

  String medicalReportUrl = "";

  final List<String> otherDocumentUrls = [];

// Selected files (before upload)
  XFile? aadhaarFile;

  XFile? panFile;

  XFile? medicalFile;

  final List<XFile> otherFiles = [];


  //==========================
  // DIGITAL SIGNATURE
  //==========================

  String memberSignatureUrl = "";

  String staffSignatureUrl = "";
  Uint8List? memberSignatureBytes;
  Uint8List? staffSignatureBytes;

  //==========================
  // DECLARATION
  //==========================

  bool declarationAccepted = false;

  void setDeclarationAccepted(bool value) {
    declarationAccepted = value;
    notifyListeners();
  }
  //==========================
  // FITNESS
  //==========================

  String fitnessGoal = "General Fitness";
  //==========================
  // INITIALIZE
  //==========================

  Future<void> initialize() async {
    memberIdController.clear();
  }

  //==========================
  // DOB -> AGE
  //==========================

  void updateDob(DateTime dob) {
    dateOfBirth = dob;

    final age = AgeCalculator.ageFromDob(dob);

    ageController.text = age.toString();
    dobController.text = DateFormat('dd MMM yyyy').format(dob);

    notifyListeners();
  }

  //==========================
  // AGE -> DOB
  //==========================

  void updateAge(int age) {
    ageController.text = age.toString();

    final dob = AgeCalculator.dobFromAge(age);

    if (dob != null) {
      dateOfBirth = dob;
      dobController.text = DateFormat('dd MMM yyyy').format(dob);
    }

    notifyListeners();
  }
  void setGender(String value) {
    gender = value;
    notifyListeners();
  }
  void setMemberStatus(bool value) {
    isActive = value;
    notifyListeners();
  }
  void setMembershipPlan(String plan) {
    membershipPlan = plan;

    switch (plan) {
      case "Monthly":
        expiryDate = DateTime(
          joiningDate.year,
          joiningDate.month + 1,
          joiningDate.day,
        );
        break;

      case "Quarterly":
        expiryDate = DateTime(
          joiningDate.year,
          joiningDate.month + 3,
          joiningDate.day,
        );
        break;

      case "Half Yearly":
        expiryDate = DateTime(
          joiningDate.year,
          joiningDate.month + 6,
          joiningDate.day,
        );
        break;

      case "Yearly":
        expiryDate = DateTime(
          joiningDate.year + 1,
          joiningDate.month,
          joiningDate.day,
        );
        break;

      default:
        expiryDate = null;
    }

    notifyListeners();
  }
  void setAdmissionDate(DateTime date) {
    admissionDate = date;
    notifyListeners();
  }

  void setJoiningDate(DateTime date) {
    joiningDate = date;

    // Recalculate expiry date
    setMembershipPlan(membershipPlan);

    notifyListeners();
  }


  //==========================
  // BMI
  //==========================

  void calculateBMI() {
    final height =
        double.tryParse(heightController.text) ?? 0;

    final weight =
        double.tryParse(weightController.text) ?? 0;

    bmi = BMICalculator.calculate(
      heightCm: height,
      weightKg: weight,
    );

    bmiCategory =
        BMICalculator.category(bmi);

    bmiRemark =
        BMICalculator.remark(bmi);

    notifyListeners();
  }
  MemberModel buildMember({
    required String memberId,
    required String gymId,
  }) {
    return MemberModel(
      // Identity
      memberId: memberId,
      gymId: gymId,
      fullName: fullNameController.text.trim(),
      photoUrl: photoUrl,

      // Personal
      dateOfBirth: dateOfBirth,
      age: int.tryParse(ageController.text) ?? 0,
      gender: gender,
      phone: mobileController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      occupation: occupationController.text.trim(),

      // Admission & Membership
      admissionDate: admissionDate,
      joiningDate: joiningDate,
      membershipExpiryDate: expiryDate,
      membershipPlan: membershipPlan,
      membershipStatus: membershipStatus,
      assignedTrainer: assignedTrainer,
      batch: batch,
      admissionSource: admissionSource,
      remarks: remarksController.text.trim(),

      // Payment Summary
      admissionFee:
      double.tryParse(admissionFeeController.text) ?? 0,
      membershipFee:
      double.tryParse(membershipFeeController.text) ?? 0,
      discountAmount:
      double.tryParse(discountController.text) ?? 0,
      totalAmount:
      double.tryParse(finalAmountController.text) ?? 0,
      paidAmount:
      double.tryParse(paidAmountController.text) ?? 0,
      dueAmount:
      double.tryParse(dueAmountController.text) ?? 0,
      paymentMode: paymentMode,
      nextDueDate: nextDueDate,

      // Health
      height:
      double.tryParse(heightController.text) ?? 0,
      weight:
      double.tryParse(weightController.text) ?? 0,
      bmi: bmi,
      fitnessGoal: fitnessGoal,

      // Emergency
      emergencyContactName:
      emergencyNameController.text.trim(),
      emergencyContactPhone:
      emergencyMobileController.text.trim(),
      emergencyRelationship:
      emergencyRelationshipController.text.trim(),

      // Medical
      bloodGroup:
      bloodGroupController.text.trim(),
      medicalConditions:
      diseaseController.text.trim(),
      allergies:
      allergyController.text.trim(),
      medicalRemarks:
      medicalRemarksController.text.trim(),

      // Documents
      aadhaarNumber:
      aadhaarNumberController.text.trim(),

      panNumber:
      panNumberController.text.trim(),

      aadhaarDocumentUrl:
      aadhaarDocumentUrl,

      panDocumentUrl:
      panDocumentUrl,

      medicalReportUrl:
      medicalReportUrl,

      otherDocumentUrls:
      List<String>.from(otherDocumentUrls),

      memberSignatureUrl:
      memberSignatureUrl,

      staffSignatureUrl:
      staffSignatureUrl,

      // System
      isActive: isActive,
      searchName:
      fullNameController.text.trim().toLowerCase(),
      version: 1,
    );
  }

  //==========================
  // RESET
  //==========================

  Future<void> reset() async {
    fullNameController.clear();

    ageController.clear();

    dobController.clear();

    aadhaarNumberController.clear();

    panNumberController.clear();

    aadhaarDocumentUrl = "";

    panDocumentUrl = "";

    medicalReportUrl = "";

    otherDocumentUrls.clear();

    memberSignatureUrl = "";

    staffSignatureUrl = "";

    declarationAccepted = false;

    fitnessGoal = "General Fitness";

    mobileController.clear();

    alternateMobileController.clear();

    emailController.clear();

    addressController.clear();

    admissionFeeController.clear();

    membershipFeeController.clear();

    discountController.clear();

    finalAmountController.clear();

    paidAmountController.clear();

    dueAmountController.clear();

    transactionIdController.clear();

    receiptNumberController.clear();

    paymentRemarksController.clear();

    heightController.clear();

    weightController.clear();

    bmi = 0;

    bmiCategory = "";

    bmiRemark = "";

    photoUrl = "";

    selectedPhoto = null;
    memberSignatureBytes = null;
    staffSignatureBytes = null;

    memberSignatureUrl = "";
    staffSignatureUrl = "";
    gender = "Male";

    isActive = true;

    membershipPlan = "Monthly";

    dateOfBirth = null;

    joiningDate = DateTime.now();

    expiryDate = null;

    memberIdController.clear();


    notifyListeners();
  }

  //==========================
  // DISPOSE
  //==========================

  @override
  void dispose() {
    fullNameController.dispose();

    ageController.dispose();

    dobController.dispose();

    memberIdController.dispose();

    mobileController.dispose();

    alternateMobileController.dispose();

    emailController.dispose();

    addressController.dispose();

    cityController.dispose();

    stateController.dispose();

    pinCodeController.dispose();

    occupationController.dispose();

    emergencyContactNameController.dispose();

    emergencyContactNumberController.dispose();

    admissionFeeController.dispose();

    membershipFeeController.dispose();

    discountController.dispose();

    finalAmountController.dispose();

    paidAmountController.dispose();

    dueAmountController.dispose();

    transactionIdController.dispose();

    receiptNumberController.dispose();

    paymentRemarksController.dispose();

    heightController.dispose();

    weightController.dispose();

    chestController.dispose();

    waistController.dispose();

    hipController.dispose();

    leftArmController.dispose();

    rightArmController.dispose();

    leftThighController.dispose();

    rightThighController.dispose();

    calfController.dispose();

    bloodPressureController.dispose();

    sugarController.dispose();

    heartRateController.dispose();

    remarksController.dispose();

    emergencyNameController.dispose();

    emergencyRelationshipController.dispose();

    emergencyMobileController.dispose();

    emergencyAddressController.dispose();

    bloodGroupController.dispose();

    diseaseController.dispose();

    allergyController.dispose();

    medicationController.dispose();

    surgeryController.dispose();

    doctorNameController.dispose();

    doctorMobileController.dispose();

    medicalRemarksController.dispose();

    aadhaarNumberController.dispose();

    panNumberController.dispose();

    super.dispose();
  }
}