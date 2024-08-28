import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/exeption.dart';
import 'package:fate_app/features/characters/data/datasources/characters_lds.dart';
import 'package:fate_app/features/characters/data/mapper/models_mapper.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';

import '../../../../core/error/failure.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersLDS charactersLDS;

  const CharactersRepositoryImpl(this.charactersLDS);

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAll() async {
    try {
      final res = await charactersLDS.getAll();

      return Right(res.map((e) => e.toEntity()).toList());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveNew(CharacterEntity character) async {
    try {
      await charactersLDS.insert(CharacterModel.fromEntity(character));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> update(CharacterEntity character) async {
    try {
      await charactersLDS.update(CharacterModel.fromEntity(character));
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCharacter(int id) async {
    try {
      await charactersLDS.delete(id);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
