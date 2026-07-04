import 'failures.dart';

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

final class FailureResult<T> extends Result<T> {
  final AppFailure failure;

  const FailureResult(this.failure);
}