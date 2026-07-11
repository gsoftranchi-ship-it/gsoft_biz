import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/audit_info.dart';
import 'base/entity_status.dart';
import 'base/tenant_info.dart';

///------------------------------------------------------------
/// Diet Goal
///------------------------------------------------------------
enum DietGoal {
  weightLoss,
  weightGain,
  muscleGain,
  fatLoss,
  maintenance,
  competition,
  custom,
}

///------------------------------------------------------------
/// Diet Plan Status
///------------------------------------------------------------
enum DietPlanStatus {
  draft,
  active,
  completed,
  cancelled,
}

///------------------------------------------------------------
/// Diet Plan Model
///------------------------------------------------------------
class DietPlanModel {
  ///==============================
  /// Primary
  ///==============================

  final String dietPlanId;

  ///==============================
  /// References
  ///==============================

  final String memberId;

  final String trainerId;

  ///==============================
  /// Plan
  ///==============================

  final String planName;

  final DietGoal goal;

  final DietPlanStatus planStatus;

  final DateTime startDate;

  final DateTime? endDate;

  ///==============================
  /// Nutrition Target
  ///==============================

  final double targetCalories;

  final double targetProtein;

  final double targetCarbohydrate;

  final double targetFat;

  final double targetWater;

  ///==============================
  /// Notes
  ///==============================

  final String notes;

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

  const DietPlanModel({
    required this.dietPlanId,

    required this.memberId,
    required this.trainerId,

    required this.planName,
    required this.goal,
    required this.planStatus,

    required this.startDate,
    this.endDate,

    required this.targetCalories,
    required this.targetProtein,
    required this.targetCarbohydrate,
    required this.targetFat,
    required this.targetWater,

    required this.notes,

    required this.version,

    required this.tenantInfo,
    required this.auditInfo,
    required this.status,
  });
  factory DietPlanModel.fromMap(
      Map<String, dynamic> map,
      String documentId,
      ) {
    return DietPlanModel(
      dietPlanId: documentId,

      memberId: map['memberId'] ?? '',
      trainerId: map['trainerId'] ?? '',

      planName: map['planName'] ?? '',

      goal: DietGoal.values.firstWhere(
            (e) => e.name == (map['goal'] ?? 'custom'),
        orElse: () => DietGoal.custom,
      ),

      planStatus: DietPlanStatus.values.firstWhere(
            (e) => e.name == (map['planStatus'] ?? 'draft'),
        orElse: () => DietPlanStatus.draft,
      ),

      startDate:
      (map['startDate'] as Timestamp?)?.toDate() ??
          DateTime.now(),

      endDate:
      (map['endDate'] as Timestamp?)?.toDate(),

      targetCalories:
      (map['targetCalories'] ?? 0).toDouble(),

      targetProtein:
      (map['targetProtein'] ?? 0).toDouble(),

      targetCarbohydrate:
      (map['targetCarbohydrate'] ?? 0).toDouble(),

      targetFat:
      (map['targetFat'] ?? 0).toDouble(),

      targetWater:
      (map['targetWater'] ?? 0).toDouble(),

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

    DietPlanModel copyWith({
      String? dietPlanId,
      String? memberId,
      String? trainerId,
      String? planName,
      DietGoal? goal,
      DietPlanStatus? planStatus,
      DateTime? startDate,
      DateTime? endDate,
      double? targetCalories,
      double? targetProtein,
      double? targetCarbohydrate,
      double? targetFat,
      double? targetWater,
      String? notes,
      int? version,
      TenantInfo? tenantInfo,
      AuditInfo? auditInfo,
      EntityStatus? status,
    }) {
      return DietPlanModel(
        dietPlanId: dietPlanId ?? this.dietPlanId,
        memberId: memberId ?? this.memberId,
        trainerId: trainerId ?? this.trainerId,
        planName: planName ?? this.planName,
        goal: goal ?? this.goal,
        planStatus: planStatus ?? this.planStatus,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        targetCalories: targetCalories ?? this.targetCalories,
        targetProtein: targetProtein ?? this.targetProtein,
        targetCarbohydrate:
        targetCarbohydrate ?? this.targetCarbohydrate,
        targetFat: targetFat ?? this.targetFat,
        targetWater: targetWater ?? this.targetWater,
        notes: notes ?? this.notes,
        version: version ?? this.version,
        tenantInfo: tenantInfo ?? this.tenantInfo,
        auditInfo: auditInfo ?? this.auditInfo,
        status: status ?? this.status,
      );
    }
  }
