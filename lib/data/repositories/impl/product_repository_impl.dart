import '../../../core/result/failures.dart';
import '../../../core/result/result.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../models/product_model.dart';
import '../../datasources/remote/firebase/firestore_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required FirestoreDataSource firestoreDataSource,
  }) : _firestoreDataSource = firestoreDataSource;

  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<List<ProductModel>>> getProducts({
    required String gymId,
  }) async {
    try {
      final products = await _firestoreDataSource.getProducts(
        gymId: gymId,
      );

      return Success(products);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<ProductModel>> getProduct({
    required String productId,
  }) async {
    try {
      final product = await _firestoreDataSource.getProduct(
        productId: productId,
      );

      if (product == null) {
        return const FailureResult(
          DatabaseFailure('Product not found.'),
        );
      }

      return Success(product);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> addProduct(
      ProductModel product,
      ) async {
    try {
      await _firestoreDataSource.addProduct(product);

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> updateProduct(
      ProductModel product,
      ) async {
    try {
      await _firestoreDataSource.updateProduct(product);

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> deleteProduct({
    required String productId,
  }) async {
    try {
      await _firestoreDataSource.deleteProduct(productId);

      return const Success(null);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<List<ProductModel>>> searchProducts({
    required String gymId,
    required String keyword,
  }) async {
    try {
      final products =
      await _firestoreDataSource.searchProducts(
        gymId: gymId,
        keyword: keyword,
      );

      return Success(products);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Result<String>> generateNextProductId() async {
    try {
      final id =
      await _firestoreDataSource.generateNextProductId();

      return Success(id);
    } catch (e) {
      return FailureResult(
        DatabaseFailure(e.toString()),
      );
    }
  }
}