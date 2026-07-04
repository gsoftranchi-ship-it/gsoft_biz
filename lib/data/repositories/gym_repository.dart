import '../../../core/result/failures.dart';
import '../../../core/result/result.dart';
import '../../../domain/repositories/gym_repository.dart';
import '../../../models/gym_model.dart';
import '../datasources/remote/firebase/firestore_datasource.dart';

class GymRepositoryImpl implements GymRepository {
  GymRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<GymModel>> getGym({
    required String gymId,
  }) async {
    try {
      final gym = await _firestoreDataSource.getGym(gymId);

      if (gym == null) {
        return const FailureResult(
          DatabaseFailure(
            'Gym profile not found.',
          ),
        );
      }

      return Success(gym);
    } catch (e) {
      return FailureResult(
        UnknownFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<void>> saveGym(
      GymModel gym,
      ) async {
    return const FailureResult(
      UnknownFailure(
        'Not implemented yet.',
      ),
    );
  }

  @override
  Future<Result<void>> updateGym(
      GymModel gym,
      ) async {
    return const FailureResult(
      UnknownFailure(
        'Not implemented yet.',
      ),
    );
  }
}