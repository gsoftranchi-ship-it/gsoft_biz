class MembershipInfo {
  final DateTime admissionDate;

  final DateTime joiningDate;

  final DateTime? expiryDate;

  final String membershipPlan;

  final String assignedTrainer;

  final String batch;

  final String membershipStatus;

  final String admissionSource;

  final String remarks;

  const MembershipInfo({
    required this.admissionDate,
    required this.joiningDate,
    this.expiryDate,
    required this.membershipPlan,
    required this.assignedTrainer,
    required this.batch,
    required this.membershipStatus,
    required this.admissionSource,
    required this.remarks,
  });

  factory MembershipInfo.fromMap(
      Map<String, dynamic> map,
      ) {
    return MembershipInfo(
      admissionDate: map['admissionDate'] != null
          ? DateTime.parse(map['admissionDate'])
          : DateTime.now(),
      joiningDate: map['joiningDate'] != null
          ? DateTime.parse(map['joiningDate'])
          : DateTime.now(),
      expiryDate: map['expiryDate'] != null
          ? DateTime.parse(map['expiryDate'])
          : null,
      membershipPlan: map['membershipPlan'] ?? '',
      assignedTrainer: map['assignedTrainer'] ?? '',
      batch: map['batch'] ?? '',
      membershipStatus: map['membershipStatus'] ?? '',
      admissionSource: map['admissionSource'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admissionDate': admissionDate.toIso8601String(),
      'joiningDate': joiningDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'membershipPlan': membershipPlan,
      'assignedTrainer': assignedTrainer,
      'batch': batch,
      'membershipStatus': membershipStatus,
      'admissionSource': admissionSource,
      'remarks': remarks,
    };
  }

  MembershipInfo copyWith({
    DateTime? admissionDate,
    DateTime? joiningDate,
    DateTime? expiryDate,
    String? membershipPlan,
    String? assignedTrainer,
    String? batch,
    String? membershipStatus,
    String? admissionSource,
    String? remarks,
  }) {
    return MembershipInfo(
      admissionDate: admissionDate ?? this.admissionDate,
      joiningDate: joiningDate ?? this.joiningDate,
      expiryDate: expiryDate ?? this.expiryDate,
      membershipPlan:
      membershipPlan ?? this.membershipPlan,
      assignedTrainer:
      assignedTrainer ?? this.assignedTrainer,
      batch: batch ?? this.batch,
      membershipStatus:
      membershipStatus ?? this.membershipStatus,
      admissionSource:
      admissionSource ?? this.admissionSource,
      remarks: remarks ?? this.remarks,
    );
  }
}