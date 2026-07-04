import '../../core/result/result.dart';
import '../../models/gym_model.dart';

abstract class GymRepository {
  Future<Result<GymModel>> getGym({
    required String gymId,
  });

  Future<Result<void>> saveGym(
      GymModel gym,
      );

  Future<Result<void>> updateGym(
      GymModel gym,
      );
}