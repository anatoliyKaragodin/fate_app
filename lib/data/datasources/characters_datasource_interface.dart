import 'package:fate_app/data/mapper/models_mapper.dart';

abstract class CharactersDataSourceInterface {
  Future<List<CharacterModel>> getAllCharacters();

  Future<void> insertCharacter(CharacterModel character);

  Future<void> updateCharacter(CharacterModel character);
}
