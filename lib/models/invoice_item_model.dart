import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Invoice Item Type
///------------------------------------------------------------
enum InvoiceItemType {
  membership,
  product,
  service,
  trainer,
  locker,
  diet,
  miscellaneous,
}

///------------------------------------------------------------
/// Invoice Item Model
///------------------------------------------------------------
class InvoiceItemModel {
  ///==============================
  /// Primary
  ///==============================

  final String invoiceItemId;

  final String invoiceId;

  ///==============================
  /// Reference
  ///==============================

  final InvoiceItemType itemType;

  /// Product ID / Membership ID / Service ID
  final String referenceId;

  ///==============================
  /// Item Information
  ///==============================

  final String itemCode;

  /// Barcode (Future POS)
  final String barcode;

  final String itemName;

  final String description;

  final String hsnSacCode;

  final String unit;

  ///==============================
  /// Quantity
  ///==============================

  final double quantity;

  ///==============================
  /// Pricing
  ///==============================

  final double purchasePrice;

  final double sellingPrice;

  final double unitPrice;

  final double discountAmount;

  final double discountPercentage;

  final double taxPercentage;

  final double taxAmount;

  final double lineTotal;

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

  const InvoiceItemModel({
    required this.invoiceItemId,
    required this.invoiceId,

    required this.itemType,
    required this.referenceId,

    required this.itemCode,
    required this.barcode,
    required this.itemName,
    required this.description,
    required this.hsnSacCode,
    required this.unit,

    required this.quantity,

    required this.purchasePrice,
    required this.sellingPrice,
    required this.unitPrice,

    required this.discountAmount,
    required this.discountPercentage,

    required this.taxPercentage,
    required this.taxAmount,

    required this.lineTotal,

    required this.remarks,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory InvoiceItemModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return InvoiceItemModel(
      invoiceItemId: documentId,

      invoiceId: map['invoiceId'] ?? '',

      itemType: InvoiceItemType.values.firstWhere(
            (e) => e.name == (map['itemType'] ?? 'product'),
        orElse: () => InvoiceItemType.product,
      ),

      referenceId: map['referenceId'] ?? '',

      itemCode: map['itemCode'] ?? '',

      barcode: map['barcode'] ?? '',

      itemName: map['itemName'] ?? '',

      description: map['description'] ?? '',

      hsnSacCode: map['hsnSacCode'] ?? '',

      unit: map['unit'] ?? '',

      quantity: (map['quantity'] ?? 0).toDouble(),

      purchasePrice: (map['purchasePrice'] ?? 0).toDouble(),

      sellingPrice: (map['sellingPrice'] ?? 0).toDouble(),

      unitPrice: (map['unitPrice'] ?? 0).toDouble(),

      discountAmount: (map['discountAmount'] ?? 0).toDouble(),

      discountPercentage:
      (map['discountPercentage'] ?? 0).toDouble(),

      taxPercentage:
      (map['taxPercentage'] ?? 0).toDouble(),

      taxAmount: (map['taxAmount'] ?? 0).toDouble(),

      lineTotal: (map['lineTotal'] ?? 0).toDouble(),

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
  Map<String, dynamic> toMap() {
    return {
      ///==============================
      /// Invoice
      ///==============================
      'invoiceId': invoiceId,

      ///==============================
      /// Item Reference
      ///==============================
      'itemType': itemType.name,
      'referenceId': referenceId,

      ///==============================
      /// Item Information
      ///==============================
      'itemCode': itemCode,
      'barcode': barcode,
      'itemName': itemName,
      'description': description,
      'hsnSacCode': hsnSacCode,
      'unit': unit,

      ///==============================
      /// Quantity
      ///==============================
      'quantity': quantity,

      ///==============================
      /// Pricing
      ///==============================
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'unitPrice': unitPrice,

      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,

      'taxPercentage': taxPercentage,
      'taxAmount': taxAmount,

      'lineTotal': lineTotal,

      ///==============================
      /// Remarks
      ///==============================
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
  InvoiceItemModel copyWith({
    String? invoiceItemId,
    String? invoiceId,
    InvoiceItemType? itemType,
    String? referenceId,
    String? itemCode,
    String? barcode,
    String? itemName,
    String? description,
    String? hsnSacCode,
    String? unit,
    double? quantity,
    double? purchasePrice,
    double? sellingPrice,
    double? unitPrice,
    double? discountAmount,
    double? discountPercentage,
    double? taxPercentage,
    double? taxAmount,
    double? lineTotal,
    String? remarks,
    int? version,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return InvoiceItemModel(
      invoiceItemId: invoiceItemId ?? this.invoiceItemId,
      invoiceId: invoiceId ?? this.invoiceId,
      itemType: itemType ?? this.itemType,
      referenceId: referenceId ?? this.referenceId,
      itemCode: itemCode ?? this.itemCode,
      barcode: barcode ?? this.barcode,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      hsnSacCode: hsnSacCode ?? this.hsnSacCode,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      unitPrice: unitPrice ?? this.unitPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentage:
      discountPercentage ?? this.discountPercentage,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      taxAmount: taxAmount ?? this.taxAmount,
      lineTotal: lineTotal ?? this.lineTotal,
      remarks: remarks ?? this.remarks,
      version: version ?? this.version,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}