import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAll();

  Future<Either<Failure, void>> saveNew(CharacterEntity character);

  Future<Either<Failure, void>> update(CharacterEntity character);

  Future<Either<Failure, void>> deleteCharacter(int id);
}
