
import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';


class CopyFile extends UseCase<String?, String> {
  final FileRepository repository;

  CopyFile(this.repository);

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.copy(params);
  }
}

