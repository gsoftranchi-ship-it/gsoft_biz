class ProductModel {
  final String productId;
  final String gymId;

  final String productName;
  final String categoryId;

  final String unit;

  final double purchasePrice;
  final double sellingPrice;

  final int reorderLevel;

  final bool isActive;

  final String searchName;

  final int version;

  const ProductModel({
    required this.productId,
    required this.gymId,
    required this.productName,
    required this.categoryId,
    required this.unit,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.reorderLevel,
    required this.isActive,
    required this.searchName,
    required this.version,
  });

  factory ProductModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return ProductModel(
      productId: map['productId'] ?? id,
      gymId: map['gymId'] ?? '',
      productName: map['productName'] ?? '',
      categoryId: map['categoryId'] ?? '',
      unit: map['unit'] ?? 'Nos',
      purchasePrice:
      (map['purchasePrice'] ?? 0).toDouble(),
      sellingPrice:
      (map['sellingPrice'] ?? 0).toDouble(),
      reorderLevel:
      map['reorderLevel'] ?? 0,
      isActive:
      map['isActive'] ?? true,
      searchName:
      map['searchName'] ?? '',
      version:
      map['version'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'gymId': gymId,
      'productName': productName,
      'categoryId': categoryId,
      'unit': unit,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'reorderLevel': reorderLevel,
      'isActive': isActive,
      'searchName': searchName,
      'version': version,
    };
  }

  ProductModel copyWith({
    String? productId,
    String? gymId,
    String? productName,
    String? categoryId,
    String? unit,
    double? purchasePrice,
    double? sellingPrice,
    int? reorderLevel,
    bool? isActive,
    String? searchName,
    int? version,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      gymId: gymId ?? this.gymId,
      productName: productName ?? this.productName,
      categoryId: categoryId ?? this.categoryId,
      unit: unit ?? this.unit,
      purchasePrice:
      purchasePrice ?? this.purchasePrice,
      sellingPrice:
      sellingPrice ?? this.sellingPrice,
      reorderLevel:
      reorderLevel ?? this.reorderLevel,
      isActive:
      isActive ?? this.isActive,
      searchName:
      searchName ?? this.searchName,
      version:
      version ?? this.version,
    );
  }
}