class EmergencyInfo {
  final String name;
  final String relationship;
  final String mobile;
  final String address;

  const EmergencyInfo({
    required this.name,
    required this.relationship,
    required this.mobile,
    required this.address,
  });

  factory EmergencyInfo.fromMap(Map<String, dynamic> map) {
    return EmergencyInfo(
      name: map['name'] ?? '',
      relationship: map['relationship'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'relationship': relationship,
      'mobile': mobile,
      'address': address,
    };
  }

  EmergencyInfo copyWith({
    String? name,
    String? relationship,
    String? mobile,
    String? address,
  }) {
    return EmergencyInfo(
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
    );
  }
}