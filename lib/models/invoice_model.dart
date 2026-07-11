import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Invoice Type
///------------------------------------------------------------
enum InvoiceType {
  membership,
  sale,
  purchase,
  service,
  adjustment,
  returnSale,
  returnPurchase,
}

///------------------------------------------------------------
/// Payment Status
///------------------------------------------------------------
enum PaymentStatus {
  unpaid,
  partial,
  paid,
  cancelled,
  refunded,
}

///------------------------------------------------------------
/// Invoice Model
///------------------------------------------------------------
class InvoiceModel {
  ///==============================
  /// Primary Information
  ///==============================

  final String invoiceId;

  final String invoiceNumber;

  final InvoiceType invoiceType;

  ///==============================
  /// Customer / Supplier
  ///==============================

  /// Member ID (nullable)
  final String? memberId;

  /// Walk-in Customer ID (nullable)
  final String? customerId;

  /// Supplier ID (Purchase Invoice)
  final String? supplierId;

  final String customerName;

  final String customerPhone;

  final String customerEmail;

  final String customerAddress;

  final String customerGstin;

  ///==============================
  /// Invoice Dates
  ///==============================

  final DateTime invoiceDate;

  final DateTime? dueDate;

  ///==============================
  /// Financial Summary
  ///==============================

  final double subtotal;

  final double discountAmount;

  final double discountPercentage;

  final double taxableAmount;

  final double cgstAmount;

  final double sgstAmount;

  final double igstAmount;

  final double taxAmount;

  final double grandTotal;

  final double receivedAmount;

  final double balanceAmount;

  ///==============================
  /// Payment
  ///==============================

  final PaymentStatus paymentStatus;

  /// Cash / Card / UPI / Bank
  final String paymentMethod;

  ///==============================
  /// Invoice Information
  ///==============================

  final String amountInWords;

  final String notes;

  ///==============================
  /// Version
  ///==============================

  final int version;

  ///==============================
  /// Common Entities
  ///==============================

  final TenantInfo tenantInfo;

  final AuditInfo auditInfo;

  final EntityStatus status;

  const InvoiceModel({
    required this.invoiceId,
    required this.invoiceNumber,
    required this.invoiceType,

    this.memberId,
    this.customerId,
    this.supplierId,

    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerAddress,
    required this.customerGstin,

    required this.invoiceDate,
    this.dueDate,

    required this.subtotal,
    required this.discountAmount,
    required this.discountPercentage,
    required this.taxableAmount,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.taxAmount,
    required this.grandTotal,
    required this.receivedAmount,
    required this.balanceAmount,

    required this.paymentStatus,
    required this.paymentMethod,

    required this.amountInWords,
    required this.notes,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });

  factory InvoiceModel.fromMap(Map<String, dynamic> map,
      String documentId,) {
    return InvoiceModel(
      invoiceId: documentId,

      invoiceNumber: map['invoiceNumber'] ?? '',

      invoiceType: InvoiceType.values.firstWhere(
            (e) => e.name == (map['invoiceType'] ?? 'sale'),
        orElse: () => InvoiceType.sale,
      ),

      memberId: map['memberId'],
      customerId: map['customerId'],
      supplierId: map['supplierId'],

      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      customerEmail: map['customerEmail'] ?? '',
      customerAddress: map['customerAddress'] ?? '',
      customerGstin: map['customerGstin'] ?? '',

      invoiceDate:
      (map['invoiceDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),

      dueDate:
      (map['dueDate'] as Timestamp?)?.toDate(),

      subtotal:
      (map['subtotal'] ?? 0).toDouble(),

      discountAmount:
      (map['discountAmount'] ?? 0).toDouble(),

      discountPercentage:
      (map['discountPercentage'] ?? 0).toDouble(),

      taxableAmount:
      (map['taxableAmount'] ?? 0).toDouble(),

      cgstAmount:
      (map['cgstAmount'] ?? 0).toDouble(),

      sgstAmount:
      (map['sgstAmount'] ?? 0).toDouble(),

      igstAmount:
      (map['igstAmount'] ?? 0).toDouble(),

      taxAmount:
      (map['taxAmount'] ?? 0).toDouble(),

      grandTotal:
      (map['grandTotal'] ?? 0).toDouble(),

      receivedAmount:
      (map['receivedAmount'] ?? 0).toDouble(),

      balanceAmount:
      (map['balanceAmount'] ?? 0).toDouble(),

      paymentStatus: PaymentStatus.values.firstWhere(
            (e) => e.name == (map['paymentStatus'] ?? 'unpaid'),
        orElse: () => PaymentStatus.unpaid,
      ),

      paymentMethod: map['paymentMethod'] ?? '',

      amountInWords: map['amountInWords'] ?? '',

      notes: map['notes'] ?? '',

      version: map['version'] ?? 1,

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
      ///==============================
      /// Invoice Information
      ///==============================
      'invoiceNumber': invoiceNumber,
      'invoiceType': invoiceType.name,

      ///==============================
      /// Customer / Supplier
      ///==============================
      'memberId': memberId,
      'customerId': customerId,
      'supplierId': supplierId,

      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'customerAddress': customerAddress,
      'customerGstin': customerGstin,

      ///==============================
      /// Dates
      ///==============================
      'invoiceDate': Timestamp.fromDate(invoiceDate),

      'dueDate': dueDate == null
          ? null
          : Timestamp.fromDate(dueDate!),

      ///==============================
      /// Financial Summary
      ///==============================
      'subtotal': subtotal,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
      'taxableAmount': taxableAmount,

      'cgstAmount': cgstAmount,
      'sgstAmount': sgstAmount,
      'igstAmount': igstAmount,

      'taxAmount': taxAmount,

      'grandTotal': grandTotal,

      'receivedAmount': receivedAmount,

      'balanceAmount': balanceAmount,

      ///==============================
      /// Payment
      ///==============================
      'paymentStatus': paymentStatus.name,

      'paymentMethod': paymentMethod,

      ///==============================
      /// Misc
      ///==============================
      'amountInWords': amountInWords,

      'notes': notes,

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