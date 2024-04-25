import 'package:fate_app/data/datasources/characters_datasource_interface.dart';
import 'package:fate_app/data/mapper/models_mapper.dart';
import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersDataSourceInterface charactersLDS;

  const CharactersRepositoryImpl(this.charactersLDS);

  @override
  Future<List<CharacterEntity>> getAll() async {
    final res = await charactersLDS.getAllCharacters();

    return res.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveNew(CharacterEntity character) async {
    await charactersLDS.insertCharacter(CharacterModel.fromEntity(character));
  }

  @override
  Future<void> update(CharacterEntity character) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }
}
