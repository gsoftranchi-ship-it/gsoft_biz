import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

class AttendanceModel {
  final String attendanceId;

  final String memberId;

  final DateTime attendanceDate;

  final DateTime? checkInTime;

  final DateTime? checkOutTime;

  final bool isPresent;

  final String remarks;

  final TenantInfo tenantInfo;

  final AuditInfo auditInfo;

  final EntityStatus status;

  const AttendanceModel({
    required this.attendanceId,
    required this.memberId,
    required this.attendanceDate,
    this.checkInTime,
    this.checkOutTime,
    required this.isPresent,
    required this.remarks,
    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory AttendanceModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return AttendanceModel(
      attendanceId: documentId,
      memberId: map['memberId'] ?? '',
      attendanceDate:
      (map['attendanceDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      checkInTime:
      (map['checkInTime'] as Timestamp?)?.toDate(),
      checkOutTime:
      (map['checkOutTime'] as Timestamp?)?.toDate(),
      isPresent: map['isPresent'] ?? false,
      remarks: map['remarks'] ?? '',
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
      'memberId': memberId,
      'attendanceDate': Timestamp.fromDate(attendanceDate),
      'checkInTime': checkInTime == null
          ? null
          : Timestamp.fromDate(checkInTime!),
      'checkOutTime': checkOutTime == null
          ? null
          : Timestamp.fromDate(checkOutTime!),
      'isPresent': isPresent,
      'remarks': remarks,
      'gymId': tenantInfo.gymId,
      'createdAt': Timestamp.fromDate(auditInfo.createdAt),
      'updatedAt': Timestamp.fromDate(auditInfo.updatedAt),
      'createdBy': auditInfo.createdBy,
      'updatedBy': auditInfo.updatedBy,
      'status': status.name,
    };
  }
  AttendanceModel copyWith({
    String? attendanceId,
    String? memberId,
    DateTime? attendanceDate,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    bool? isPresent,
    String? remarks,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return AttendanceModel(
      attendanceId: attendanceId ?? this.attendanceId,
      memberId: memberId ?? this.memberId,
      attendanceDate: attendanceDate ?? this.attendanceDate,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      isPresent: isPresent ?? this.isPresent,
      remarks: remarks ?? this.remarks,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}
