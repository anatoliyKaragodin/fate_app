import 'package:fate_app/domain/entities/character_entity.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';

class GetCharacters {
  final CharactersRepository repository;

  GetCharacters(this.repository);

  Future<List<CharacterEntity>> get() async {
    return await repository.getAll();
  }
}
