import '../../../../core/result/result.dart';
import '../../../../models/purchase_model.dart';

abstract class PurchaseDataSource {
  /// Load all purchases for a gym
  Future<Result<List<PurchaseModel>>> getPurchases({
    required String gymId,
  });

  /// Load a single purchase
  Future<Result<PurchaseModel>> getPurchase({
    required String purchaseId,
  });

  /// Create purchase
  Future<Result<void>> addPurchase(
      PurchaseModel purchase,
      );

  /// Update purchase
  Future<Result<void>> updatePurchase(
      PurchaseModel purchase,
      );

  /// Delete/Cancel purchase
  Future<Result<void>> deletePurchase({
    required String purchaseId,
  });

  /// Generate next purchase ID
  Future<Result<String>> generateNextPurchaseId();

  /// Search purchases
  Future<Result<List<PurchaseModel>>> searchPurchases({
    required String gymId,
    required String keyword,
  });
}