import '../../../core/result/failures.dart';
import '../../../core/result/result.dart';
import '../../../domain/repositories/purchase_repository.dart';
import '../../../models/purchase_model.dart';
import '../../datasources/remote/firebase/firestore_datasource.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  PurchaseRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<List<PurchaseModel>>> getPurchases({
    required String gymId,
  }) async {
    try {
      final purchases = await _firestoreDataSource.getPurchases(
        gymId: gymId,
      );

      return Success(purchases);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<PurchaseModel>> getPurchase({
    required String purchaseId,
  }) async {
    try {
      final purchase = await _firestoreDataSource.getPurchase(
        purchaseId: purchaseId,
      );

      if (purchase == null) {
        return FailureResult(
          const DatabaseFailure('Purchase not found.'),
        );
      }

      return Success(purchase);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> addPurchase(
      PurchaseModel purchase,
      ) async {
    try {
      await _firestoreDataSource.addPurchase(
        purchase,
      );

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> updatePurchase(
      PurchaseModel purchase,
      ) async {
    try {
      await _firestoreDataSource.updatePurchase(
        purchase,
      );

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> deletePurchase({
    required String purchaseId,
  }) async {
    try {
      await _firestoreDataSource.deletePurchase(
        purchaseId,
      );

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<PurchaseModel>>> searchPurchases({
    required String gymId,
    required String keyword,
  }) async {
    try {
      final purchases =
      await _firestoreDataSource.searchPurchases(
        gymId: gymId,
        keyword: keyword,
      );

      return Success(purchases);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<String>> generateNextPurchaseId() {
    // TODO: Implement during Purchase Number service integration.
    throw UnimplementedError();
  }
}