import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/result/failures.dart';
import '../../../core/result/result.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../models/user_model.dart';
import '../../datasources/remote/firebase/auth_datasource.dart';
import '../../datasources/remote/firebase/firestore_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource authDataSource,
    required FirestoreDataSource firestoreDataSource,
  })  : _authDataSource = authDataSource,
        _firestoreDataSource = firestoreDataSource;

  final AuthDataSource _authDataSource;
  final FirestoreDataSource _firestoreDataSource;

  @override
  Future<Result<UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _authDataSource.signIn(
        email: email,
        password: password,
      );

      final uid = credential.user?.uid;

      if (uid == null) {
        return const FailureResult(
          AuthenticationFailure(
            'Unable to identify authenticated user.',
          ),
        );
      }

      final user =
      await _firestoreDataSource.getUser(uid);

      if (user == null) {
        return const FailureResult(
          DatabaseFailure(
            'User profile not found.',
          ),
        );
      }

      return Success(user);
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
          message =
          'Invalid Partner ID or Password. Please check your credentials and try again.';
          break;

        case 'user-not-found':
          message =
          'No account found for the provided Partner ID. Please register your gym or contact support.';
          break;

        case 'invalid-email':
          message =
          'Please enter a valid Partner ID.';
          break;

        case 'user-disabled':
          message =
          'Your account has been disabled. Please contact GYM ERP Support.';
          break;

        case 'too-many-requests':
          message =
          'Too many failed login attempts. Please try again after a few minutes.';
          break;

        case 'network-request-failed':
          message =
          'Unable to connect to the server. Please check your internet connection.';
          break;

        default:
          message =
          'Unable to sign in at the moment. Please try again later.';
      }

      return FailureResult(
        AuthenticationFailure(message),
      );
    } catch (_) {
      return const FailureResult(
        UnknownFailure(),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Success(null);
    } catch (_) {
      return const FailureResult(
        UnknownFailure(
          'Unable to sign out.',
        ),
      );
    }
  }

  @override
  Future<Result<UserModel?>> getCurrentUser() async {
    return const Success<UserModel?>(null);
  }

  @override
  Future<bool> isLoggedIn() async {
    return _authDataSource.isLoggedIn();
  }

  @override
  Future<Result<void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _authDataSource.sendPasswordResetEmail(
        email: email,
      );

      return const Success(null);
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'user-not-found':
          message =
          'No account found for the provided Partner ID.';
          break;

        case 'invalid-email':
          message =
          'Please enter a valid Partner ID.';
          break;

        case 'network-request-failed':
          message =
          'Unable to connect to the server. Please check your internet connection.';
          break;

        default:
          message =
          'Unable to send the password reset email. Please try again later.';
      }

      return FailureResult(
        AuthenticationFailure(message),
      );
    }
  }
}