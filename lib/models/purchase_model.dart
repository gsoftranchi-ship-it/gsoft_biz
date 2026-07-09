class PurchaseModel {
  final String purchaseId;
  final String gymId;
  final String supplierId;
  final String invoiceNumber;

  final DateTime purchaseDate;

  final double subTotal;
  final double discount;
  final double tax;
  final double grandTotal;
  final double paidAmount;
  final double dueAmount;

  final String paymentMethod;

  final String remarks;

  final bool isCancelled;

  final int version;

  const PurchaseModel({
    required this.purchaseId,
    required this.gymId,
    required this.supplierId,
    required this.invoiceNumber,
    required this.purchaseDate,
    required this.subTotal,
    required this.discount,
    required this.tax,
    required this.grandTotal,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentMethod,
    required this.remarks,
    required this.isCancelled,
    required this.version,
  });

  factory PurchaseModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return PurchaseModel(
      purchaseId: map['purchaseId'] ?? id,
      gymId: map['gymId'] ?? '',
      supplierId: map['supplierId'] ?? '',
      invoiceNumber: map['invoiceNumber'] ?? '',
      purchaseDate: DateTime.parse(
        map['purchaseDate'],
      ),
      subTotal: (map['subTotal'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      tax: (map['tax'] ?? 0).toDouble(),
      grandTotal: (map['grandTotal'] ?? 0).toDouble(),
      paidAmount: (map['paidAmount'] ?? 0).toDouble(),
      dueAmount: (map['dueAmount'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? 'Cash',
      remarks: map['remarks'] ?? '',
      isCancelled: map['isCancelled'] ?? false,
      version: map['version'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': purchaseId,
      'gymId': gymId,
      'supplierId': supplierId,
      'invoiceNumber': invoiceNumber,
      'purchaseDate': purchaseDate.toIso8601String(),
      'subTotal': subTotal,
      'discount': discount,
      'tax': tax,
      'grandTotal': grandTotal,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMethod': paymentMethod,
      'remarks': remarks,
      'isCancelled': isCancelled,
      'version': version,
    };
  }

  PurchaseModel copyWith({
    String? purchaseId,
    String? gymId,
    String? supplierId,
    String? invoiceNumber,
    DateTime? purchaseDate,
    double? subTotal,
    double? discount,
    double? tax,
    double? grandTotal,
    double? paidAmount,
    double? dueAmount,
    String? paymentMethod,
    String? remarks,
    bool? isCancelled,
    int? version,
  }) {
    return PurchaseModel(
      purchaseId: purchaseId ?? this.purchaseId,
      gymId: gymId ?? this.gymId,
      supplierId: supplierId ?? this.supplierId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      subTotal: subTotal ?? this.subTotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      grandTotal: grandTotal ?? this.grandTotal,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      remarks: remarks ?? this.remarks,
      isCancelled: isCancelled ?? this.isCancelled,
      version: version ?? this.version,
    );
  }
}