import 'package:fate_app/domain/entities/character_entity.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class UpdateCharacter {
  final CharactersRepository repository;

  UpdateCharacter(this.repository);

  Future<void> update(CharacterEntity character) async {
    return await repository.update(character);
  }
}
