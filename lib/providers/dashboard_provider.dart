import 'package:flutter/foundation.dart';

import '../core/result/result.dart';
import '../domain/repositories/gym_repository.dart';
import '../models/gym_model.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider({
    required GymRepository repository,
  }) : _repository = repository;

  final GymRepository _repository;

  bool _isLoading = false;
  GymModel? _gym;

  bool get isLoading => _isLoading;

  GymModel? get gym => _gym;

  Future<void> loadGym({
    required String gymId,
  }) async {
    _isLoading = true;
    notifyListeners();

    final result = await _repository.getGym(
      gymId: gymId,
    );

    switch (result) {
      case Success<GymModel>():
        _gym = result.data;

      case FailureResult<GymModel>():
        _gym = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}