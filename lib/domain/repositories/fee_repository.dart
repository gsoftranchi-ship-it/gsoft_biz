import '../../core/result/result.dart';
import '../../models/fee_model.dart';

abstract class FeeRepository {
  Future<Result<List<FeeModel>>> getFees({
    required String gymId,
  });

  Future<Result<List<FeeModel>>> getMemberFees({
    required String gymId,
    required String memberId,
  });

  Future<Result<List<FeeModel>>> getDueFees({
    required String gymId,
  });

  Future<Result<void>> addFee(FeeModel fee);

  Future<Result<void>> updateFee(FeeModel fee);

  Future<Result<void>> deleteFee(String feeId);

  Future<Result<FeeModel?>> getFeeById({
    required String gymId,
    required String feeId,
  });
}