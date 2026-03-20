import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final Object? cause;

  const Failure({this.message, this.cause});

  @override
  List<Object?> get props => [message, cause];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.cause});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message, super.cause});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message, super.cause});
}

/// Пользователь отменил длительную операцию (например закрыл запрос к API).
class OperationCancelledFailure extends Failure {
  const OperationCancelledFailure({super.message, super.cause});
}
