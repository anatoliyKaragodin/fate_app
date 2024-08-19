import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';

import '../repositories/file_repository.dart';

class DeleteFile extends UseCase<void, String> {
  final FileRepository repository;

  DeleteFile(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.delete(params);
  }
}
