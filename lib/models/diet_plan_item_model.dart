import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Meal Type
///------------------------------------------------------------
enum MealType {
  breakfast,
  morningSnack,
  lunch,
  eveningSnack,
  preWorkout,
  postWorkout,
  dinner,
  bedtime,
}

///------------------------------------------------------------
/// Diet Plan Item Model
///------------------------------------------------------------
class DietPlanItemModel {

  ///==============================
  /// Primary
  ///==============================

  final String dietPlanItemId;

  final String dietPlanId;

  ///==============================
  /// Product
  ///==============================

  /// Optional Inventory Product
  final String productId;

  final String foodName;

  final String unit;

  final double quantity;

  ///==============================
  /// Meal
  ///==============================

  final MealType mealType;

  final String instructions;

  ///==============================
  /// Nutrition
  ///==============================

  final double calories;

  final double protein;

  final double carbohydrate;

  final double fat;

  ///==============================
  /// Billable
  ///==============================

  /// Example:
  /// Whey = true
  /// Banana = false
  final bool isBillable;

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

  const DietPlanItemModel({
    required this.dietPlanItemId,
    required this.dietPlanId,

    required this.productId,

    required this.foodName,
    required this.unit,
    required this.quantity,

    required this.mealType,
    required this.instructions,

    required this.calories,
    required this.protein,
    required this.carbohydrate,
    required this.fat,

    required this.isBillable,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory DietPlanItemModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return DietPlanItemModel(
      dietPlanItemId: documentId,

      dietPlanId: map['dietPlanId'] ?? '',

      productId: map['productId'] ?? '',

      foodName: map['foodName'] ?? '',

      unit: map['unit'] ?? '',

      quantity: (map['quantity'] ?? 0).toDouble(),

      mealType: MealType.values.firstWhere(
            (e) => e.name == (map['mealType'] ?? 'breakfast'),
        orElse: () => MealType.breakfast,
      ),

      instructions: map['instructions'] ?? '',

      calories: (map['calories'] ?? 0).toDouble(),

      protein: (map['protein'] ?? 0).toDouble(),

      carbohydrate:
      (map['carbohydrate'] ?? 0).toDouble(),

      fat: (map['fat'] ?? 0).toDouble(),

      isBillable: map['isBillable'] ?? false,

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
      /// References
      ///==============================
      'dietPlanId': dietPlanId,
      'productId': productId,

      ///==============================
      /// Food
      ///==============================
      'foodName': foodName,
      'unit': unit,
      'quantity': quantity,

      ///==============================
      /// Meal
      ///==============================
      'mealType': mealType.name,
      'instructions': instructions,

      ///==============================
      /// Nutrition
      ///==============================
      'calories': calories,
      'protein': protein,
      'carbohydrate': carbohydrate,
      'fat': fat,

      ///==============================
      /// Billing
      ///==============================
      'isBillable': isBillable,

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
  DietPlanItemModel copyWith({
    String? dietPlanItemId,
    String? dietPlanId,
    String? productId,
    String? foodName,
    String? unit,
    double? quantity,
    MealType? mealType,
    String? instructions,
    double? calories,
    double? protein,
    double? carbohydrate,
    double? fat,
    bool? isBillable,
    int? version,
    TenantInfo? tenantInfo,
    AuditInfo? auditInfo,
    EntityStatus? status,
  }) {
    return DietPlanItemModel(
      dietPlanItemId: dietPlanItemId ?? this.dietPlanItemId,
      dietPlanId: dietPlanId ?? this.dietPlanId,
      productId: productId ?? this.productId,
      foodName: foodName ?? this.foodName,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      mealType: mealType ?? this.mealType,
      instructions: instructions ?? this.instructions,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrate: carbohydrate ?? this.carbohydrate,
      fat: fat ?? this.fat,
      isBillable: isBillable ?? this.isBillable,
      version: version ?? this.version,
      tenantInfo: tenantInfo ?? this.tenantInfo,
      auditInfo: auditInfo ?? this.auditInfo,
      status: status ?? this.status,
    );
  }
}