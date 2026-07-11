import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Payment Method
///------------------------------------------------------------
enum PaymentMethod {
  cash,
  upi,
  card,
  bankTransfer,
  cheque,
  wallet,
  online,
}

///------------------------------------------------------------
/// Payment Type
///------------------------------------------------------------
enum PaymentType {
  payment,
  refund,
}

///------------------------------------------------------------
/// Payment Model
///------------------------------------------------------------
class PaymentModel {
  ///==============================
  /// Primary
  ///==============================

  final String paymentId;

  final String invoiceId;

  ///==============================
  /// Payment
  ///==============================

  final PaymentType paymentType;

  final PaymentMethod paymentMethod;

  final DateTime paymentDate;

  final double amount;

  ///==============================
  /// Reference
  ///==============================

  /// Transaction No / UTR / Cheque No
  final String referenceNumber;

  /// Bank Name / UPI App
  final String paymentSource;

  final String remarks;

  ///==============================
  /// Version
  ///==============================

  final int version;

  ///==============================
  /// Common
  ///==============================

  final TenantInfo tenantInfo;

  final AuditInfo auditInfo;

  final EntityStatus status;

  const PaymentModel({
    required this.paymentId,
    required this.invoiceId,

    required this.paymentType,
    required this.paymentMethod,

    required this.paymentDate,

    required this.amount,

    required this.referenceNumber,
    required this.paymentSource,
    required this.remarks,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map,
      String documentId,) {
    return PaymentModel(
      paymentId: documentId,

      invoiceId: map['invoiceId'] ?? '',

      paymentType: PaymentType.values.firstWhere(
            (e) => e.name == (map['paymentType'] ?? 'payment'),
        orElse: () => PaymentType.payment,
      ),

      paymentMethod: PaymentMethod.values.firstWhere(
            (e) => e.name == (map['paymentMethod'] ?? 'cash'),
        orElse: () => PaymentMethod.cash,
      ),

      paymentDate:
      (map['paymentDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),

      amount:
      (map['amount'] ?? 0).toDouble(),

      referenceNumber:
      map['referenceNumber'] ?? '',

      paymentSource:
      map['paymentSource'] ?? '',

      remarks:
      map['remarks'] ?? '',

      version:
      map['version'] ?? 1,

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

        createdBy:
        map['createdBy'] ?? '',

        updatedBy:
        map['updatedBy'] ?? '',
      ),

      status: EntityStatus.values.firstWhere(
            (e) => e.name == (map['status'] ?? 'active'),
        orElse: () => EntityStatus.active,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ///==============================
      /// Invoice
      ///==============================
      'invoiceId': invoiceId,

      ///==============================
      /// Payment
      ///==============================
      'paymentType': paymentType.name,
      'paymentMethod': paymentMethod.name,
      'paymentDate': Timestamp.fromDate(paymentDate),
      'amount': amount,

      ///==============================
      /// Reference
      ///==============================
      'referenceNumber': referenceNumber,
      'paymentSource': paymentSource,
      'remarks': remarks,

      ///==============================
      /// Version
      ///==============================
      'version': version,

      ///==============================
      /// Tenant
      ///==============================
      'gymId': tenantInfo.gymId,

      ///==============================
      /// Audit
      ///==============================
      'createdAt': Timestamp.fromDate(
        auditInfo.createdAt,
      ),

      'updatedAt': Timestamp.fromDate(
        auditInfo.updatedAt,
      ),

      'createdBy': auditInfo.createdBy,

      'updatedBy': auditInfo.updatedBy,

      ///==============================
      /// Status
      ///==============================
      'status': status.name,
    };
  }
}