import '../core/enums/app_role.dart';
import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? phone;

  final AppRole role;
  final bool isActive;

  final TenantInfo tenantInfo;
  final AuditInfo auditInfo;
  final EntityStatus status;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    required this.role,
    required this.isActive,
    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory UserModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return UserModel(
      id: documentId,
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      role: AppRole.values.firstWhere(
            (e) => e.name == (map['role'] ?? 'member'),
        orElse: () => AppRole.member,
      ),
      isActive: map['isActive'] ?? true,

      tenantInfo: TenantInfo(
        gymId: map['gymId'] ?? '',
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
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'gymId': tenantInfo.gymId,
      'role': role.name,
      'isActive': isActive,
      'status': status.name,
      'createdAt': auditInfo.createdAt,
      'updatedAt': auditInfo.updatedAt,
      'createdBy': auditInfo.createdBy,
      'updatedBy': auditInfo.updatedBy,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    AppRole? role,
    bool? isActive,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}
