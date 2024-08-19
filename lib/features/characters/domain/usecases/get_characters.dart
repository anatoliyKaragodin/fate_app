import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';

class GetCharacters extends UseCase<List<CharacterEntity>, void>{
  final CharactersRepository repository;

  GetCharacters(this.repository);

  

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(void params) async {
    return await repository.getAll();
  }
}
