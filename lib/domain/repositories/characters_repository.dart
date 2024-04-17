import 'package:fate_app/domain/entities/character_entity.dart';

abstract class CharactersRepository {
  Future<List<CharacterEntity>> getAll();

  Future<void> saveNew(CharacterEntity character);

  Future<void> update(CharacterEntity character);
}
