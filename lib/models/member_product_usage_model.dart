import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Usage Status
///------------------------------------------------------------
enum ProductUsageStatus {
  pending,
  issued,
  cancelled,
}

///------------------------------------------------------------
/// Member Product Usage
///------------------------------------------------------------
class MemberProductUsageModel {

  ///==============================
  /// Primary
  ///==============================

  final String usageId;

  ///==============================
  /// References
  ///==============================

  final String memberId;

  final String trainerId;

  final String productId;

  /// Optional
  final String invoiceId;

  final String invoiceItemId;

  ///==============================
  /// Product
  ///==============================

  final String productCode;

  final String barcode;

  final String productName;

  final String unit;

  ///==============================
  /// Usage
  ///==============================

  final double quantity;

  final DateTime issuedDate;

  final bool isBillable;

  final ProductUsageStatus usageStatus;

  ///==============================
  /// Remarks
  ///==============================

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

  const MemberProductUsageModel({
    required this.usageId,

    required this.memberId,
    required this.trainerId,
    required this.productId,

    required this.invoiceId,
    required this.invoiceItemId,

    required this.productCode,
    required this.barcode,
    required this.productName,
    required this.unit,

    required this.quantity,
    required this.issuedDate,

    required this.isBillable,
    required this.usageStatus,

    required this.remarks,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory MemberProductUsageModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return MemberProductUsageModel(
      usageId: documentId,

      memberId: map['memberId'] ?? '',
      trainerId: map['trainerId'] ?? '',
      productId: map['productId'] ?? '',

      invoiceId: map['invoiceId'] ?? '',
      invoiceItemId: map['invoiceItemId'] ?? '',

      productCode: map['productCode'] ?? '',
      barcode: map['barcode'] ?? '',
      productName: map['productName'] ?? '',
      unit: map['unit'] ?? '',

      quantity: (map['quantity'] ?? 0).toDouble(),

      issuedDate:
      (map['issuedDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),

      isBillable: map['isBillable'] ?? false,

      usageStatus: ProductUsageStatus.values.firstWhere(
            (e) => e.name == (map['usageStatus'] ?? 'issued'),
        orElse: () => ProductUsageStatus.issued,
      ),

      remarks: map['remarks'] ?? '',

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
  MemberProductUsageModel copyWith({
    String? usageId,
    String? memberId,
    String? trainerId,
    String? productId,
    String? invoiceId,
    String? invoiceItemId,
    String? productCode,
    String? barcode,
    String? productName,
    String? unit,
    double? quantity,
    DateTime? issuedDate,
    bool? isBillable,
    ProductUsageStatus? usageStatus,
    String? remarks,
    int? version,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return MemberProductUsageModel(
      usageId: usageId ?? this.usageId,
      memberId: memberId ?? this.memberId,
      trainerId: trainerId ?? this.trainerId,
      productId: productId ?? this.productId,
      invoiceId: invoiceId ?? this.invoiceId,
      invoiceItemId: invoiceItemId ?? this.invoiceItemId,
      productCode: productCode ?? this.productCode,
      barcode: barcode ?? this.barcode,
      productName: productName ?? this.productName,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      issuedDate: issuedDate ?? this.issuedDate,
      isBillable: isBillable ?? this.isBillable,
      usageStatus: usageStatus ?? this.usageStatus,
      remarks: remarks ?? this.remarks,
      version: version ?? this.version,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}