import 'package:fate_app/domain/entities/character_entity.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class SaveNewCharacter {
  final CharactersRepository repository;

  SaveNewCharacter(this.repository);

  Future<void> save(CharacterEntity character) async {
    return await repository.saveNew(character);
  }
}