import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';

import '../repositories/characters_repository.dart';

class DeleteCharacter extends UseCase<void, int> {
  final CharactersRepository repository;

  DeleteCharacter(this.repository);

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.deleteCharacter(params);
  }
}
