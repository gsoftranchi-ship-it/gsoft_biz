import '../../core/result/result.dart';
import '../../models/purchase_model.dart';

abstract class PurchaseRepository {
  /// Load all purchases for a gym
  Future<Result<List<PurchaseModel>>> getPurchases({
    required String gymId,
  });

  /// Get a single purchase
  Future<Result<PurchaseModel>> getPurchase({
    required String purchaseId,
  });

  /// Create a purchase
  Future<Result<void>> addPurchase(
      PurchaseModel purchase,
      );

  /// Update an existing purchase
  Future<Result<void>> updatePurchase(
      PurchaseModel purchase,
      );

  /// Cancel/Delete a purchase
  Future<Result<void>> deletePurchase({
    required String purchaseId,
  });

  /// Generate next purchase number
  Future<Result<String>> generateNextPurchaseId();

  /// Search purchases
  Future<Result<List<PurchaseModel>>> searchPurchases({
    required String gymId,
    required String keyword,
  });
}