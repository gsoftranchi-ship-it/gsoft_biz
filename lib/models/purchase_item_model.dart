class PurchaseItemModel {
  final String purchaseItemId;
  final String purchaseId;
  final String productId;

  final double quantity;
  final double purchasePrice;
  final double lineTotal;

  final int version;

  const PurchaseItemModel({
    required this.purchaseItemId,
    required this.purchaseId,
    required this.productId,
    required this.quantity,
    required this.purchasePrice,
    required this.lineTotal,
    required this.version,
  });

  factory PurchaseItemModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return PurchaseItemModel(
      purchaseItemId: map['purchaseItemId'] ?? id,
      purchaseId: map['purchaseId'] ?? '',
      productId: map['productId'] ?? '',
      quantity: (map['quantity'] ?? 0).toDouble(),
      purchasePrice: (map['purchasePrice'] ?? 0).toDouble(),
      lineTotal: (map['lineTotal'] ?? 0).toDouble(),
      version: map['version'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseItemId': purchaseItemId,
      'purchaseId': purchaseId,
      'productId': productId,
      'quantity': quantity,
      'purchasePrice': purchasePrice,
      'lineTotal': lineTotal,
      'version': version,
    };
  }

  PurchaseItemModel copyWith({
    String? purchaseItemId,
    String? purchaseId,
    String? productId,
    double? quantity,
    double? purchasePrice,
    double? lineTotal,
    int? version,
  }) {
    return PurchaseItemModel(
      purchaseItemId: purchaseItemId ?? this.purchaseItemId,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      lineTotal: lineTotal ?? this.lineTotal,
      version: version ?? this.version,
    );
  }
}