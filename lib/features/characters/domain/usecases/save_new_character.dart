import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';

class SaveNewCharacter extends UseCase<void, CharacterEntity> {
  final CharactersRepository repository;

  SaveNewCharacter(this.repository);

  @override
  Future<Either<Failure, void>> call(CharacterEntity params) async {
    // final char = params.copyWith(createdAt: DateTime.now());

    return await repository.saveNew(params);
  }
}
