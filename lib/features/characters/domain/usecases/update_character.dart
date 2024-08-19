import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';

class UpdateCharacter extends UseCase<void, CharacterEntity> {
  final CharactersRepository repository;

  UpdateCharacter(this.repository);

  @override
  Future<Either<Failure, void>> call(CharacterEntity params) async {
    return await repository.update(params);
  }
}
