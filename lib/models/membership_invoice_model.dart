import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

class MembershipInvoiceModel {
  final String invoiceId;

  final String memberId;

  final String invoiceNumber;

  final DateTime invoiceDate;

  final DateTime? dueDate;

  final double admissionFee;

  final double membershipFee;

  final double discount;

  final double taxAmount;

  final double totalAmount;

  final double paidAmount;

  final double dueAmount;

  final String remarks;

  final bool isPaid;

  final TenantInfo tenantInfo;

  final AuditInfo auditInfo;

  final EntityStatus status;

  const MembershipInvoiceModel({
    required this.invoiceId,
    required this.memberId,
    required this.invoiceNumber,
    required this.invoiceDate,
    this.dueDate,
    required this.admissionFee,
    required this.membershipFee,
    required this.discount,
    required this.taxAmount,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.remarks,
    required this.isPaid,
    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });

  factory MembershipInvoiceModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return MembershipInvoiceModel(
      invoiceId: documentId,
      memberId: map['memberId'] ?? '',
      invoiceNumber: map['invoiceNumber'] ?? '',
      invoiceDate:
      (map['invoiceDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      dueDate:
      (map['dueDate'] as Timestamp?)?.toDate(),
      admissionFee:
      (map['admissionFee'] ?? 0).toDouble(),
      membershipFee:
      (map['membershipFee'] ?? 0).toDouble(),
      discount:
      (map['discount'] ?? 0).toDouble(),
      taxAmount:
      (map['taxAmount'] ?? 0).toDouble(),
      totalAmount:
      (map['totalAmount'] ?? 0).toDouble(),
      paidAmount:
      (map['paidAmount'] ?? 0).toDouble(),
      dueAmount:
      (map['dueAmount'] ?? 0).toDouble(),
      remarks: map['remarks'] ?? '',
      isPaid: map['isPaid'] ?? false,
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
      'invoiceNumber': invoiceNumber,
      'invoiceDate': Timestamp.fromDate(invoiceDate),
      'dueDate':
      dueDate == null ? null : Timestamp.fromDate(dueDate!),
      'admissionFee': admissionFee,
      'membershipFee': membershipFee,
      'discount': discount,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'remarks': remarks,
      'isPaid': isPaid,
      'gymId': tenantInfo.gymId,
      'createdAt': Timestamp.fromDate(auditInfo.createdAt),
      'updatedAt': Timestamp.fromDate(auditInfo.updatedAt),
      'createdBy': auditInfo.createdBy,
      'updatedBy': auditInfo.updatedBy,
      'status': status.name,
    };
  }

  MembershipInvoiceModel copyWith({
    String? invoiceId,
    String? memberId,
    String? invoiceNumber,
    DateTime? invoiceDate,
    DateTime? dueDate,
    double? admissionFee,
    double? membershipFee,
    double? discount,
    double? taxAmount,
    double? totalAmount,
    double? paidAmount,
    double? dueAmount,
    String? remarks,
    bool? isPaid,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return MembershipInvoiceModel(
      invoiceId: invoiceId ?? this.invoiceId,
      memberId: memberId ?? this.memberId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      dueDate: dueDate ?? this.dueDate,
      admissionFee: admissionFee ?? this.admissionFee,
      membershipFee: membershipFee ?? this.membershipFee,
      discount: discount ?? this.discount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      remarks: remarks ?? this.remarks,
      isPaid: isPaid ?? this.isPaid,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}