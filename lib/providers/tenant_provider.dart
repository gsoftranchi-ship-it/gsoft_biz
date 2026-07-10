import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/gym_repository.dart';
import '../models/gym_model.dart';

class TenantProvider extends ChangeNotifier {
  TenantProvider({
    required GymRepository repository,
  }) : _repository = repository;

  final GymRepository _repository;

  GymModel? _currentGym;

  bool _loading = false;

  AppFailure? _failure;

  GymModel? get currentGym => _currentGym;

  bool get loading => _loading;

  AppFailure? get failure => _failure;

  bool get hasGym => _currentGym != null;

  Future<void> loadGym({
    required String gymId,
  }) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.getGym(
      gymId: gymId,
    );

    switch (result) {
      case Success<GymModel>():
        _currentGym = result.data;

      case FailureResult<GymModel>():
        _failure = result.failure;
    }

    _loading = false;
    notifyListeners();
  }

  Future<bool> saveGym(
      GymModel gym,
      ) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    try {
      final result = await _repository.saveGym(gym);

      switch (result) {
        case Success<void>():
          _currentGym = gym;
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

  Future<bool> updateGym(
      GymModel gym,
      ) async {
    _loading = true;
    _failure = null;
    notifyListeners();

    try {
      final result = await _repository.updateGym(gym);

      switch (result) {
        case Success<void>():
          _currentGym = gym;
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

  Future<void> refresh() async {
    final gymId = _currentGym?.id;

    if (gymId == null || gymId.isEmpty) {
      return;
    }

    await loadGym(
      gymId: gymId,
    );
  }

  void clear() {
    _currentGym = null;
    _failure = null;
    _loading = false;
    notifyListeners();
  }
}