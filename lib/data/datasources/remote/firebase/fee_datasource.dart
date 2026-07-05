import '../../../../models/fee_model.dart';

abstract class FeeDatasource {
  /// Create a fee document.
  Future<void> createFee(FeeModel fee);

  /// Update an existing fee document.
  Future<void> updateFee(FeeModel fee);

  /// Soft delete a fee document.
  Future<void> deleteFee(String feeId);

  /// Get a fee by its ID.
  Future<FeeModel?> getFeeById(String feeId);

  /// Get all active fees for the current gym.
  Future<List<FeeModel>> getFees(String gymId);

  /// Get all fees for a specific member.
  Future<List<FeeModel>> getMemberFees({
    required String gymId,
    required String memberId,
  });

  /// Get all unpaid fees for the current gym.
  Future<List<FeeModel>> getDueFees(String gymId);
}