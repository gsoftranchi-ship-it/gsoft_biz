import '../../models/fee_model.dart';

abstract class FeeRepository {
  /// Create a new fee record.
  Future<void> createFee(FeeModel fee);

  /// Update an existing fee.
  Future<void> updateFee(FeeModel fee);

  /// Soft delete a fee.
  Future<void> deleteFee(String feeId);

  /// Get a single fee by ID.
  Future<FeeModel?> getFeeById(String feeId);

  /// Get all active fees for the current gym.
  Future<List<FeeModel>> getFees();

  /// Get all fees for a member.
  Future<List<FeeModel>> getMemberFees(String memberId);

  /// Get all unpaid fees.
  Future<List<FeeModel>> getDueFees();
}