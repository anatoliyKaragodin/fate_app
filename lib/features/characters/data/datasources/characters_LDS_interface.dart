import 'package:fate_app/features/characters/data/mapper/models_mapper.dart';

abstract class CharactersLDSInterface {
  Future<List<CharacterModel>> getAll();

  Future<void> insert(CharacterModel character);

  Future<void> update(CharacterModel character);

  Future<void> delete(int id);
}
