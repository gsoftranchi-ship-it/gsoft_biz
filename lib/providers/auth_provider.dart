import 'package:flutter/foundation.dart';

import '../core/result/failures.dart';
import '../core/result/result.dart';
import '../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required AuthRepository repository,
  }) : _repository = repository;

  final AuthRepository _repository;

  bool _isLoading = false;
  UserModel? _currentUser;
  AppFailure? _failure;

  bool get isLoading => _isLoading;
  UserModel? get currentUser => _currentUser;
  AppFailure? get failure => _failure;

  bool get isLoggedIn => _currentUser != null;

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.signIn(
      email: email,
      password: password,
    );

    switch (result) {
      case Success<UserModel>():
        _currentUser = result.data;
        _isLoading = false;
        notifyListeners();
        return true;

      case FailureResult<UserModel>():
        _failure = result.failure;
        _isLoading = false;
        notifyListeners();
        return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    await _repository.signOut();

    _currentUser = null;
    _failure = null;
    _isLoading = false;

    notifyListeners();
  }

  void clearFailure() {
    _failure = null;
    notifyListeners();
  }
}