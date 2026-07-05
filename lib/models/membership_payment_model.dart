import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

class MembershipPaymentModel {
  final String paymentId;

  final String invoiceId;

  final String memberId;

  final String receiptNumber;

  final DateTime paymentDate;

  final double amount;

  final String paymentMethod;

  final String transactionId;

  final String referenceNumber;

  final String remarks;

  final TenantInfo tenantInfo;

  final AuditInfo auditInfo;

  final EntityStatus status;

  const MembershipPaymentModel({
    required this.paymentId,
    required this.invoiceId,
    required this.memberId,
    required this.receiptNumber,
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    required this.transactionId,
    required this.referenceNumber,
    required this.remarks,
    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });

  factory MembershipPaymentModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return MembershipPaymentModel(
      paymentId: documentId,
      invoiceId: map['invoiceId'] ?? '',
      memberId: map['memberId'] ?? '',
      receiptNumber: map['receiptNumber'] ?? '',
      paymentDate:
      (map['paymentDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),
      amount: (map['amount'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? '',
      transactionId: map['transactionId'] ?? '',
      referenceNumber: map['referenceNumber'] ?? '',
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
      'invoiceId': invoiceId,
      'memberId': memberId,
      'receiptNumber': receiptNumber,
      'paymentDate': Timestamp.fromDate(paymentDate),
      'amount': amount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'referenceNumber': referenceNumber,
      'remarks': remarks,
      'gymId': tenantInfo.gymId,
      'createdAt': Timestamp.fromDate(auditInfo.createdAt),
      'updatedAt': Timestamp.fromDate(auditInfo.updatedAt),
      'createdBy': auditInfo.createdBy,
      'updatedBy': auditInfo.updatedBy,
      'status': status.name,
    };
  }

  MembershipPaymentModel copyWith({
    String? paymentId,
    String? invoiceId,
    String? memberId,
    String? receiptNumber,
    DateTime? paymentDate,
    double? amount,
    String? paymentMethod,
    String? transactionId,
    String? referenceNumber,
    String? remarks,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return MembershipPaymentModel(
      paymentId: paymentId ?? this.paymentId,
      invoiceId: invoiceId ?? this.invoiceId,
      memberId: memberId ?? this.memberId,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      paymentDate: paymentDate ?? this.paymentDate,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      remarks: remarks ?? this.remarks,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}