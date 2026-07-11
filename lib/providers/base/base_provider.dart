import 'package:flutter/foundation.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  @protected
  void setLoading(bool value) {
    if (_isLoading == value) return;

    _isLoading = value;
    notifyListeners();
  }

  @protected
  void setError(String? message) {
    if (_errorMessage == message) return;

    _errorMessage = message;
    notifyListeners();
  }

  @protected
  void clearError() {
    setError(null);
  }
}