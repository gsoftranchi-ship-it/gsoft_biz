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
  String _friendlyMessage(String message) {
    final error = message.toLowerCase();

    if (error.contains('invalid-credential') ||
        error.contains('wrong-password') ||
        error.contains('invalid password')) {
      return 'Invalid Partner ID or Password. Please try again.';
    }

    if (error.contains('user-not-found')) {
      return 'No account was found for the provided Partner ID.';
    }

    if (error.contains('invalid-email')) {
      return 'Please enter a valid Partner ID.';
    }

    if (error.contains('network')) {
      return 'Unable to connect to the server. Please check your internet connection.';
    }

    if (error.contains('too-many-requests')) {
      return 'Too many failed login attempts. Please try again later.';
    }

    return 'Unable to sign in. Please try again or contact support.';
  }

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
        _failure = AuthenticationFailure(
          _friendlyMessage(result.failure.message),
        );

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

  Future<bool> sendPasswordResetEmail({
    required String email,
  }) async {
    _isLoading = true;
    _failure = null;
    notifyListeners();

    final result = await _repository.sendPasswordResetEmail(
      email: email,
    );

    switch (result) {
      case Success<void>():
        _isLoading = false;
        notifyListeners();
        return true;

      case FailureResult<void>():
        _failure = result.failure;
        _isLoading = false;
        notifyListeners();
        return false;
    }
  }

  void clearFailure() {
    _failure = null;
    notifyListeners();
  }
}