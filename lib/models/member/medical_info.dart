class MedicalInfo {
  final String bloodGroup;
  final String disease;
  final String allergy;
  final String medication;
  final String surgery;
  final String doctorName;
  final String doctorMobile;
  final String remarks;

  const MedicalInfo({
    required this.bloodGroup,
    required this.disease,
    required this.allergy,
    required this.medication,
    required this.surgery,
    required this.doctorName,
    required this.doctorMobile,
    required this.remarks,
  });

  factory MedicalInfo.fromMap(Map<String, dynamic> map) {
    return MedicalInfo(
      bloodGroup: map['bloodGroup'] ?? '',
      disease: map['disease'] ?? '',
      allergy: map['allergy'] ?? '',
      medication: map['medication'] ?? '',
      surgery: map['surgery'] ?? '',
      doctorName: map['doctorName'] ?? '',
      doctorMobile: map['doctorMobile'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bloodGroup': bloodGroup,
      'disease': disease,
      'allergy': allergy,
      'medication': medication,
      'surgery': surgery,
      'doctorName': doctorName,
      'doctorMobile': doctorMobile,
      'remarks': remarks,
    };
  }

  MedicalInfo copyWith({
    String? bloodGroup,
    String? disease,
    String? allergy,
    String? medication,
    String? surgery,
    String? doctorName,
    String? doctorMobile,
    String? remarks,
  }) {
    return MedicalInfo(
      bloodGroup: bloodGroup ?? this.bloodGroup,
      disease: disease ?? this.disease,
      allergy: allergy ?? this.allergy,
      medication: medication ?? this.medication,
      surgery: surgery ?? this.surgery,
      doctorName: doctorName ?? this.doctorName,
      doctorMobile: doctorMobile ?? this.doctorMobile,
      remarks: remarks ?? this.remarks,
    );
  }
}