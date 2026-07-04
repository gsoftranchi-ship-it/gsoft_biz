abstract class AppFailure {
  final String message;

  const AppFailure(this.message);

  @override
  String toString() => message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure([
    super.message = 'No internet connection.',
  ]);
}

final class ServerFailure extends AppFailure {
  const ServerFailure([
    super.message = 'Server error occurred.',
  ]);
}

final class AuthenticationFailure extends AppFailure {
  const AuthenticationFailure([
    super.message = 'Authentication failed.',
  ]);
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure([
    super.message = 'Permission denied.',
  ]);
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure([
    super.message = 'Validation failed.',
  ]);
}

final class DatabaseFailure extends AppFailure {
  const DatabaseFailure([
    super.message = 'Database operation failed.',
  ]);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure([
    super.message = 'Something went wrong.',
  ]);
}