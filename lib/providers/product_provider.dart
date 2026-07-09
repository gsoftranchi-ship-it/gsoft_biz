import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({
    required ProductRepository repository,
  }) : _repository = repository;

  final ProductRepository _repository;

  List<ProductModel> _products = [];

  String? _currentGymId;

  bool _loading = false;

  AppFailure? _failure;

  List<ProductModel> get products =>
      List.unmodifiable(_products);

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  Future<void> loadProducts({
    required String gymId,
  }) async {
    _currentGymId = gymId;

    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getProducts(
      gymId: gymId,
    );

    switch (result) {
      case Success<List<ProductModel>>():
        _products = result.data;

      case FailureResult<List<ProductModel>>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> search({
    required String gymId,
    required String keyword,
  }) async {
    final result = await _repository.searchProducts(
      gymId: gymId,
      keyword: keyword,
    );

    switch (result) {
      case Success<List<ProductModel>>():
        _products = result.data;

      case FailureResult<List<ProductModel>>():
        _failure = result.failure;
    }

    notifyListeners();
  }

  Future<void> refresh() async {
    if (_currentGymId == null) return;

    await loadProducts(
      gymId: _currentGymId!,
    );
  }

  Future<String?> generateNextProductId() async {
    _failure = null;

    final result =
    await _repository.generateNextProductId();

    switch (result) {
      case Success<String>():
        return result.data;

      case FailureResult<String>():
        _failure = result.failure;
        notifyListeners();
        return null;
    }
  }

  Future<bool> add(
      ProductModel product,
      ) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result =
    await _repository.addProduct(product);

    switch (result) {
      case Success<void>():
        await refresh();
        _loading = false;
        notifyListeners();
        return true;

      case FailureResult<void>():
        _failure = result.failure;
        _loading = false;
        notifyListeners();
        return false;
    }
  }

  Future<void> update(
      ProductModel product,
      ) async {
    final result =
    await _repository.updateProduct(product);

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> delete(
      String productId,
      ) async {
    final result =
    await _repository.deleteProduct(
      productId: productId,
    );

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  int get totalProducts => _products.length;

  int get activeProducts =>
      _products.where((e) => e.isActive).length;

  int get inactiveProducts =>
      _products.where((e) => !e.isActive).length;
}