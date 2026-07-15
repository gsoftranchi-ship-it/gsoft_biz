class MemberModel {

  //1. Identity
  final String memberId;
  final String gymId;
  final String fullName;
  final String photoUrl;

  // 2. Personal Information
  final DateTime? dateOfBirth;
  final int age;
  final String gender;
  final String phone;
  final String email;
  final String address;
  final String occupation;

  // 3. Admission & Membership
  final DateTime admissionDate;
  final DateTime joiningDate;
  final DateTime? membershipExpiryDate;
  final String membershipPlan;
  final String membershipStatus;
  final String assignedTrainer;
  final String batch;
  final String admissionSource;
  final String remarks;

  // 4. Payment Summary
  final double admissionFee;
  final double membershipFee;
  final double discountAmount;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String paymentMode;
  final DateTime? nextDueDate;

  // 5. Health Baseline
  final double height;
  final double weight;
  final double bmi;
  final String fitnessGoal;

  // 6. Emergency Contact
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyRelationship;

  // 7. Medical
  final String bloodGroup;
  final String medicalConditions;
  final String allergies;
  final String medicalRemarks;

  // 8. Documents
  final String aadhaarNumber;
  final String panNumber;

  final String aadhaarDocumentUrl;
  final String panDocumentUrl;
  final String medicalReportUrl;

  final List<String> otherDocumentUrls;

// 9. Digital Signature
  final String memberSignatureUrl;
  final String staffSignatureUrl;

  // 9. System
  final bool isActive;

  final String searchName;

  final int version;



  const MemberModel({
    required this.memberId,
    required this.gymId,
    required this.fullName,
    required this.photoUrl,

    this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.address,
    required this.occupation,

    required this.admissionDate,
    required this.joiningDate,
    this.membershipExpiryDate,
    required this.membershipPlan,
    required this.membershipStatus,
    required this.assignedTrainer,
    required this.batch,
    required this.admissionSource,
    required this.remarks,

    required this.admissionFee,
    required this.membershipFee,
    required this.discountAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentMode,
    this.nextDueDate,

    required this.height,
    required this.weight,
    required this.bmi,
    required this.fitnessGoal,

    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyRelationship,

    required this.bloodGroup,
    required this.medicalConditions,
    required this.allergies,
    required this.medicalRemarks,
    required this.aadhaarNumber,
    required this.panNumber,

    required this.aadhaarDocumentUrl,
    required this.panDocumentUrl,
    required this.medicalReportUrl,
    required this.otherDocumentUrls,

    required this.memberSignatureUrl,
    required this.staffSignatureUrl,

    required this.isActive,
    required this.searchName,
    required this.version,
  });



  factory MemberModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return MemberModel(
      memberId: map['memberId'] ?? id,
      gymId: map['gymId'] ?? '',
      fullName: map['fullName'] ?? '',
      photoUrl: map['photoUrl'] ?? '',

      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'])
          : null,

      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      occupation: map['occupation'] ?? '',

      admissionDate: map['admissionDate'] != null
          ? DateTime.parse(map['admissionDate'])
          : DateTime.now(),

      joiningDate: map['joiningDate'] != null
          ? DateTime.parse(map['joiningDate'])
          : DateTime.now(),

      membershipExpiryDate: map['membershipExpiryDate'] != null
          ? DateTime.parse(map['membershipExpiryDate'])
          : null,

      membershipPlan: map['membershipPlan'] ?? '',
      membershipStatus: map['membershipStatus'] ?? '',
      assignedTrainer: map['assignedTrainer'] ?? '',
      batch: map['batch'] ?? '',
      admissionSource: map['admissionSource'] ?? '',
      remarks: map['remarks'] ?? '',

      admissionFee: (map['admissionFee'] ?? 0).toDouble(),
      membershipFee: (map['membershipFee'] ?? 0).toDouble(),
      discountAmount: (map['discountAmount'] ?? 0).toDouble(),
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      paidAmount: (map['paidAmount'] ?? 0).toDouble(),
      dueAmount: (map['dueAmount'] ?? 0).toDouble(),

      paymentMode: map['paymentMode'] ?? '',

      nextDueDate: map['nextDueDate'] != null
          ? DateTime.parse(map['nextDueDate'])
          : null,

      height: (map['height'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      bmi: (map['bmi'] ?? 0).toDouble(),
      fitnessGoal: map['fitnessGoal'] ?? '',

      emergencyContactName: map['emergencyContactName'] ?? '',
      emergencyContactPhone: map['emergencyContactPhone'] ?? '',
      emergencyRelationship: map['emergencyRelationship'] ?? '',

      bloodGroup: map['bloodGroup'] ?? '',
      medicalConditions: map['medicalConditions'] ?? '',
      allergies: map['allergies'] ?? '',
      medicalRemarks: map['medicalRemarks'] ?? '',

      aadhaarNumber: map['aadhaarNumber'] ?? '',
      panNumber: map['panNumber'] ?? '',

      aadhaarDocumentUrl:
      map['aadhaarDocumentUrl'] ?? '',
      panDocumentUrl:
      map['panDocumentUrl'] ?? '',
      medicalReportUrl:
      map['medicalReportUrl'] ?? '',

      otherDocumentUrls:
      List<String>.from(
        map['otherDocumentUrls'] ?? const [],
      ),

      memberSignatureUrl:
      map['memberSignatureUrl'] ?? '',
      staffSignatureUrl:
      map['staffSignatureUrl'] ?? '',

      isActive: map['isActive'] ?? true,
      searchName: map['searchName'] ?? '',
      version: map['version'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memberId': memberId,
      'gymId': gymId,
      'fullName': fullName,
      'photoUrl': photoUrl,

      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'age': age,
      'gender': gender,
      'phone': phone,
      'email': email,
      'address': address,
      'occupation': occupation,

      'admissionDate': admissionDate.toIso8601String(),
      'joiningDate': joiningDate.toIso8601String(),
      'membershipExpiryDate':
      membershipExpiryDate?.toIso8601String(),

      'membershipPlan': membershipPlan,
      'membershipStatus': membershipStatus,
      'assignedTrainer': assignedTrainer,
      'batch': batch,
      'admissionSource': admissionSource,
      'remarks': remarks,

      'admissionFee': admissionFee,
      'membershipFee': membershipFee,
      'discountAmount': discountAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMode': paymentMode,
      'nextDueDate': nextDueDate?.toIso8601String(),

      'height': height,
      'weight': weight,
      'bmi': bmi,
      'fitnessGoal': fitnessGoal,

      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'emergencyRelationship': emergencyRelationship,

      'bloodGroup': bloodGroup,
      'medicalConditions': medicalConditions,
      'allergies': allergies,
      'medicalRemarks': medicalRemarks,

      'aadhaarNumber': aadhaarNumber,
      'panNumber': panNumber,

      'aadhaarDocumentUrl': aadhaarDocumentUrl,
      'panDocumentUrl': panDocumentUrl,
      'medicalReportUrl': medicalReportUrl,

      'otherDocumentUrls': otherDocumentUrls,

      'memberSignatureUrl': memberSignatureUrl,
      'staffSignatureUrl': staffSignatureUrl,

      'isActive': isActive,
      'searchName': searchName,
      'version': version,
    };
  }

  MemberModel copyWith({
    String? memberId,
    String? gymId,
    String? fullName,
    String? photoUrl,

    DateTime? dateOfBirth,
    int? age,
    String? gender,
    String? phone,
    String? email,
    String? address,
    String? occupation,

    DateTime? admissionDate,
    DateTime? joiningDate,
    DateTime? membershipExpiryDate,

    String? membershipPlan,
    String? membershipStatus,
    String? assignedTrainer,
    String? batch,
    String? admissionSource,
    String? remarks,

    double? admissionFee,
    double? membershipFee,
    double? discountAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,

    String? paymentMode,
    DateTime? nextDueDate,

    double? height,
    double? weight,
    double? bmi,
    String? fitnessGoal,

    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyRelationship,

    String? bloodGroup,
    String? medicalConditions,
    String? allergies,
    String? medicalRemarks,

    String? aadhaarNumber,
    String? panNumber,

    String? aadhaarDocumentUrl,
    String? panDocumentUrl,
    String? medicalReportUrl,
    List<String>? otherDocumentUrls,

    String? memberSignatureUrl,
    String? staffSignatureUrl,

    bool? isActive,
    String? searchName,
    int? version,
  }) {
    return MemberModel(
      memberId: memberId ?? this.memberId,
      gymId: gymId ?? this.gymId,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,

      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      occupation: occupation ?? this.occupation,

      admissionDate: admissionDate ?? this.admissionDate,
      joiningDate: joiningDate ?? this.joiningDate,
      membershipExpiryDate:
      membershipExpiryDate ?? this.membershipExpiryDate,

      membershipPlan: membershipPlan ?? this.membershipPlan,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      assignedTrainer: assignedTrainer ?? this.assignedTrainer,
      batch: batch ?? this.batch,
      admissionSource: admissionSource ?? this.admissionSource,
      remarks: remarks ?? this.remarks,

      admissionFee: admissionFee ?? this.admissionFee,
      membershipFee: membershipFee ?? this.membershipFee,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,

      paymentMode: paymentMode ?? this.paymentMode,
      nextDueDate: nextDueDate ?? this.nextDueDate,

      height: height ?? this.height,
      weight: weight ?? this.weight,
      bmi: bmi ?? this.bmi,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,

      emergencyContactName:
      emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
      emergencyContactPhone ?? this.emergencyContactPhone,
      emergencyRelationship:
      emergencyRelationship ?? this.emergencyRelationship,

      bloodGroup: bloodGroup ?? this.bloodGroup,
      medicalConditions:
      medicalConditions ?? this.medicalConditions,
      allergies: allergies ?? this.allergies,
      medicalRemarks:
      medicalRemarks ?? this.medicalRemarks,

      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      panNumber: panNumber ?? this.panNumber,

      aadhaarDocumentUrl:
      aadhaarDocumentUrl ?? this.aadhaarDocumentUrl,
      panDocumentUrl:
      panDocumentUrl ?? this.panDocumentUrl,
      medicalReportUrl:
      medicalReportUrl ?? this.medicalReportUrl,

      otherDocumentUrls:
      otherDocumentUrls ?? this.otherDocumentUrls,

      memberSignatureUrl:
      memberSignatureUrl ?? this.memberSignatureUrl,
      staffSignatureUrl:
      staffSignatureUrl ?? this.staffSignatureUrl,

      isActive: isActive ?? this.isActive,
      searchName: searchName ?? this.searchName,
      version: version ?? this.version,
    );
  }
}