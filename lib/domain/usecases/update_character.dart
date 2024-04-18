import 'package:fate_app/domain/mapper/models_mapper.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class UpdateCharacter {
  final CharactersRepository repository;

  UpdateCharacter(this.repository);

  Future<void> update(CharacterEntity character) async {
    return await repository.update(character);
  }
}
