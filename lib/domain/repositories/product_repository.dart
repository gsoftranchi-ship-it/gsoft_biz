import '../../core/result/result.dart';
import '../../models/product_model.dart';

abstract class ProductRepository {
  Future<Result<List<ProductModel>>> getProducts({
    required String gymId,
  });

  Future<Result<ProductModel>> getProduct({
    required String productId,
  });

  Future<Result<void>> addProduct(
      ProductModel product,
      );

  Future<Result<void>> updateProduct(
      ProductModel product,
      );

  Future<Result<void>> deleteProduct({
    required String productId,
  });

  Future<Result<List<ProductModel>>> searchProducts({
    required String gymId,
    required String keyword,
  });

  Future<Result<String>> generateNextProductId();
}