class MemberContact {
  final String mobile;

  final String alternateMobile;

  final String email;

  final String address;

  final String city;

  final String state;

  final String pinCode;

  final String occupation;

  const MemberContact({
    required this.mobile,
    required this.alternateMobile,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.occupation,
  });

  factory MemberContact.fromMap(
      Map<String, dynamic> map,
      ) {
    return MemberContact(
      mobile: map['mobile'] ?? '',
      alternateMobile: map['alternateMobile'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      pinCode: map['pinCode'] ?? '',
      occupation: map['occupation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'alternateMobile': alternateMobile,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'occupation': occupation,
    };
  }

  MemberContact copyWith({
    String? mobile,
    String? alternateMobile,
    String? email,
    String? address,
    String? city,
    String? state,
    String? pinCode,
    String? occupation,
  }) {
    return MemberContact(
      mobile: mobile ?? this.mobile,
      alternateMobile:
      alternateMobile ?? this.alternateMobile,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      occupation: occupation ?? this.occupation,
    );
  }
}