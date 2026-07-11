class MemberModel {
  final String memberId;
  final String gymId;

  final String fullName;

  final String photoUrl;

  final DateTime? dateOfBirth;

  final int age;

  final String gender;

  final bool isActive;

  final String searchName;

  final int version;

  final String phone;
  final String email;
  final String address;

  const MemberModel({
    required this.memberId,
    required this.gymId,
    required this.fullName,
    required this.photoUrl,
    this.dateOfBirth,
    required this.age,
    required this.gender,
    required this.isActive,
    required this.searchName,
    required this.version,
    required this.phone,
    required this.email,
    required this.address,

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
      isActive: map['isActive'] ?? true,
      searchName: map['searchName'] ?? '',
      version: map['version'] ?? 1,
      phone: map['phone'] ?? '',
      email:map['email']??'',
      address:map['address']?? '',

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
      'isActive': isActive,
      'searchName': searchName,
      'version': version,
      'phone': phone,
      'email': email,
      'address':address,

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
    bool? isActive,
    String? searchName,
    int? version,
    String? phone,
    String? email,
    String? address,
  }) {
    return MemberModel(
      memberId: memberId ?? this.memberId,
      gymId: gymId ?? this.gymId,
      fullName: fullName ?? this.fullName,
      photoUrl: photoUrl ?? this.photoUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
      searchName: searchName ?? this.searchName,
      version: version ?? this.version,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address:address?? this.address,
    );
  }
}