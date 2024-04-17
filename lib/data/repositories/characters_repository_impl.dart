import 'package:fate_app/domain/entities/character_entity.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  @override
  Future<List<CharacterEntity>> getAll() {
    // TODO: implement getAllCharacters
    throw UnimplementedError();
  }

  @override
  Future<void> saveNew(CharacterEntity character) {
    // TODO: implement saveNewCharacter
    throw UnimplementedError();
  }

  @override
  Future<void> update(CharacterEntity character) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }
}
