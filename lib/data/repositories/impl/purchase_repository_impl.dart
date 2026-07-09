import '../../../core/result/result.dart';
import '../../../domain/repositories/purchase_repository.dart';
import '../../../models/purchase_model.dart';
import '../../datasources/remote/firebase/purchase_datasource.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  const PurchaseRepositoryImpl({
    required PurchaseDataSource dataSource,
  }) : _dataSource = dataSource;

  final PurchaseDataSource _dataSource;

  @override
  Future<Result<void>> addPurchase(
      PurchaseModel purchase,
      ) {
    return _dataSource.addPurchase(purchase);
  }

  @override
  Future<Result<void>> deletePurchase({
    required String purchaseId,
  }) {
    return _dataSource.deletePurchase(
      purchaseId: purchaseId,
    );
  }

  @override
  Future<Result<String>> generateNextPurchaseId() {
    return _dataSource.generateNextPurchaseId();
  }

  @override
  Future<Result<PurchaseModel>> getPurchase({
    required String purchaseId,
  }) {
    return _dataSource.getPurchase(
      purchaseId: purchaseId,
    );
  }

  @override
  Future<Result<List<PurchaseModel>>> getPurchases({
    required String gymId,
  }) {
    return _dataSource.getPurchases(
      gymId: gymId,
    );
  }

  @override
  Future<Result<List<PurchaseModel>>> searchPurchases({
    required String gymId,
    required String keyword,
  }) {
    return _dataSource.searchPurchases(
      gymId: gymId,
      keyword: keyword,
    );
  }

  @override
  Future<Result<void>> updatePurchase(
      PurchaseModel purchase,
      ) {
    return _dataSource.updatePurchase(
      purchase,
    );
  }
}