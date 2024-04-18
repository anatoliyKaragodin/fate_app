
import 'package:fate_app/domain/mapper/models_mapper.dart';

abstract class CharactersRepository {
  Future<List<CharacterEntity>> getAll();

  Future<void> saveNew(CharacterEntity character);

  Future<void> update(CharacterEntity character);
}
