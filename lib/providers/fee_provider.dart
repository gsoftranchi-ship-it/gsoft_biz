import 'package:flutter/foundation.dart';
import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/fee_repository.dart';
import '../models/fee_model.dart';

class FeeProvider extends ChangeNotifier {
  FeeProvider({
    required FeeRepository repository,
  }) : _repository = repository;

  final FeeRepository _repository;

  List<FeeModel> _fees = [];

  String? _currentGymId;

  bool _loading = false;

  AppFailure? _failure;

  List<FeeModel> get fees => List.unmodifiable(_fees);

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  Future<void> loadFees({
    required String gymId,
  }) async {
    _currentGymId = gymId;

    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getFees(
      gymId: gymId,
    );

    switch (result) {
      case Success<List<FeeModel>>():
        _fees = result.data;

      case FailureResult<List<FeeModel>>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (_currentGymId == null) return;

    await loadFees(
      gymId: _currentGymId!,
    );
  }

  Future<bool> add(FeeModel fee) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.addFee(fee);

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

  Future<void> update(FeeModel fee) async {
    final result = await _repository.updateFee(fee);

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<void> delete(String feeId) async {
    final result = await _repository.deleteFee(feeId);

    switch (result) {
      case Success<void>():
        await refresh();

      case FailureResult<void>():
        _failure = result.failure;
        notifyListeners();
    }
  }

  Future<List<FeeModel>> loadMemberFees({
    required String memberId,
  }) async {
    final result = await _repository.getMemberFees(
      gymId: _currentGymId!,
      memberId: memberId,
    );

    switch (result) {
      case Success<List<FeeModel>>():
        return result.data;

      case FailureResult<List<FeeModel>>():
        _failure = result.failure;
        notifyListeners();
        return [];
    }
  }

  Future<List<FeeModel>> loadDueFees() async {
    final result = await _repository.getDueFees(
      gymId: _currentGymId!,
    );

    switch (result) {
      case Success<List<FeeModel>>():
        return result.data;

      case FailureResult<List<FeeModel>>():
        _failure = result.failure;
        notifyListeners();
        return [];
    }
  }

  int get totalFees => _fees.length;

  int get paidFees => _fees.where((e) => e.isPaid).length;

  int get dueFees => _fees.where((e) => !e.isPaid).length;
}