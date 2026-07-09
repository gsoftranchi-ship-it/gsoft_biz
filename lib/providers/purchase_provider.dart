import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/purchase_repository.dart';
import '../models/purchase_model.dart';

class PurchaseProvider extends ChangeNotifier {
  PurchaseProvider({
    required PurchaseRepository repository,
  }) : _repository = repository;

  final PurchaseRepository _repository;

  List<PurchaseModel> _purchases = [];

  String? _currentGymId;

  bool _loading = false;

  AppFailure? _failure;

  List<PurchaseModel> get purchases =>
      List.unmodifiable(_purchases);

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  Future<void> loadPurchases({
    required String gymId,
  }) async {
    _currentGymId = gymId;

    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getPurchases(
      gymId: gymId,
    );

    switch (result) {
      case Success<List<PurchaseModel>>():
        _purchases = result.data;

      case FailureResult<List<PurchaseModel>>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_currentGymId == null) return;

    await loadPurchases(
      gymId: _currentGymId!,
    );
  }

  Future<bool> add(
      PurchaseModel purchase,
      ) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    try {
      final result =
      await _repository.addPurchase(
        purchase,
      );

      switch (result) {
        case Success<void>():
          await refresh();
          return true;

        case FailureResult<void>():
          _failure = result.failure;
          return false;
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> update(
      PurchaseModel purchase,
      ) async {
    final result =
    await _repository.updatePurchase(
      purchase,
    );

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> delete({
    required String purchaseId,
  }) async {
    final result =
    await _repository.deletePurchase(
      purchaseId: purchaseId,
    );

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> search({
    required String gymId,
    required String keyword,
  }) async {
    final result =
    await _repository.searchPurchases(
      gymId: gymId,
      keyword: keyword,
    );

    switch (result) {
      case Success<List<PurchaseModel>>():
        _purchases = result.data;

      case FailureResult<List<PurchaseModel>>():
        _failure = result.failure;
    }

    notifyListeners();
  }

  int get totalPurchases => _purchases.length;
}