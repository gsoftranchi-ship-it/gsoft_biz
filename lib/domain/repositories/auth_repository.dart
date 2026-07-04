import '../../core/result/result.dart';
import '../../models/user_model.dart';

abstract class AuthRepository {
  /// Login using email & password
  Future<Result<UserModel>> signIn({
    required String email,
    required String password,
  });

  /// Logout current user
  Future<Result<void>> signOut();

  /// Returns currently logged in user
  Future<Result<UserModel?>> getCurrentUser();

  /// Checks whether a user session exists
  Future<bool> isLoggedIn();

  /// Sends password reset email
  Future<Result<void>> sendPasswordResetEmail({
    required String email,
  });
}