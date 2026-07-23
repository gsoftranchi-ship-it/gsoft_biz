import 'package:cloud_firestore/cloud_firestore.dart';
import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

class GymModel {
  final String id;

  final String gymCode;
  final String gymName;
  final String ownerName;

  final String? email;
  final String? phone;

  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pincode;

  final String? logoUrl;

  final String currency;
  final String timezone;

  final String? gstNumber;
  final String? website;

  final String? tagline;

  final String? registrationNumber;

  final String? subscriptionPlan;

  final String? subscriptionStatus;

  final int branchCount;

  final String? businessType;

  final String? supportContact;

  final DateTime? subscriptionExpiry;

  final bool isActive;

  final TenantInfo tenantInfo;
  final AuditInfo auditInfo;
  final EntityStatus status;

  const GymModel({
    required this.id,
    required this.gymCode,
    required this.gymName,
    required this.ownerName,

    this.email,
    this.phone,

    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,

    this.logoUrl,

    this.gstNumber,

    this.website,
    this.tagline,

    this.registrationNumber,

    this.subscriptionPlan,

    this.subscriptionStatus,

    this.branchCount = 1,

    this.businessType,

    this.supportContact,

    this.subscriptionExpiry,

    this.currency = 'INR',
    this.timezone = 'Asia/Kolkata',

    required this.isActive,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory GymModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return GymModel(
      id: documentId,
      gymCode: map['gymCode'] ?? '',
      gymName: map['gymName'] ?? '',
      ownerName: map['ownerName'] ?? '',

      email: map['email'],
      phone: map['phone'],

      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      pincode: map['pincode'],

      logoUrl: map['logoUrl'],

      gstNumber: map['gstNumber'],
      website: map['website'],
      tagline: map['tagline'],

      registrationNumber: map['registrationNumber'],

      subscriptionPlan: map['subscriptionPlan'],

      subscriptionStatus: map['subscriptionStatus'],

      branchCount: map['branchCount'] ?? 1,

      businessType: map['businessType'],

      supportContact: map['supportContact'],

      subscriptionExpiry:
      (map['subscriptionExpiry'] as Timestamp?)?.toDate(),

      currency: map['currency'] ?? 'INR',
      timezone: map['timezone'] ?? 'Asia/Kolkata',

      isActive: map['isActive'] ?? true,

      tenantInfo: TenantInfo(
        gymId: documentId,
      ),

      auditInfo: AuditInfo(
        createdAt:
        (map['createdAt'] as Timestamp?)?.toDate() ??
            DateTime.now(),
        updatedAt:
        (map['updatedAt'] as Timestamp?)?.toDate() ??
            DateTime.now(),
        createdBy: map['createdBy'] ?? '',
        updatedBy: map['updatedBy'] ?? '',
      ),

      status: EntityStatus.values.firstWhere(
            (e) => e.name == (map['status'] ?? 'active'),
        orElse: () => EntityStatus.active,
      ),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'gymCode': gymCode,
      'gymName': gymName,
      'ownerName': ownerName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'logoUrl': logoUrl,
      'gstNumber': gstNumber,
      'website': website,
      'tagline': tagline,
      'registrationNumber': registrationNumber,
      'subscriptionPlan': subscriptionPlan,
      'subscriptionStatus': subscriptionStatus,
      'branchCount': branchCount,
      'businessType': businessType,
      'supportContact': supportContact,
      'subscriptionExpiry': subscriptionExpiry,
      'currency': currency,
      'timezone': timezone,
      'isActive': isActive,
      'status': status.name,
      'createdAt': auditInfo.createdAt,
      'updatedAt': auditInfo.updatedAt,
      'createdBy': auditInfo.createdBy,
      'updatedBy': auditInfo.updatedBy,
    };
  }

  GymModel copyWith({
    String? id,
    String? gymCode,
    String? gymName,
    String? ownerName,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? pincode,
    String? logoUrl,
    String? gstNumber,
    String? website,
    String? tagline,
    String? registrationNumber,
    String? subscriptionPlan,
    String? subscriptionStatus,
    int? branchCount,
    String? businessType,
    String? supportContact,
    DateTime? subscriptionExpiry,
    String? currency,
    String? timezone,
    bool? isActive,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return GymModel(
      id: id ?? this.id,
      gymCode: gymCode ?? this.gymCode,
      gymName: gymName ?? this.gymName,
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
      website: website ?? this.website,
      tagline: tagline ?? this.tagline,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      gstNumber: gstNumber ?? this.gstNumber,
      currency: currency ?? this.currency,
      timezone: timezone ?? this.timezone,
      registrationNumber:
      registrationNumber ?? this.registrationNumber,
      subscriptionPlan:
      subscriptionPlan ?? this.subscriptionPlan,
      subscriptionStatus:
      subscriptionStatus ?? this.subscriptionStatus,
      branchCount:
      branchCount ?? this.branchCount,
      businessType:
      businessType ?? this.businessType,
      supportContact:
      supportContact ?? this.supportContact,
      subscriptionExpiry:
      subscriptionExpiry ?? this.subscriptionExpiry,
    );
  }
}