import 'package:fate_app/data/models/character_model.dart';

abstract class CharactersDataSourceInterface {
  Future<List<CharacterModel>> getAllCharacters();

  Future<void> insertCharacter(CharacterModel character);

  Future<void> updateCharacter(CharacterModel character);
}
