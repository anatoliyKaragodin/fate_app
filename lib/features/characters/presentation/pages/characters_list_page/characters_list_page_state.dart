part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharactersListPageState with CharactersListPageStateMappable {
  final List<CharacterEntity> characters;
  final bool isEditing;

  const CharactersListPageState(
      {required this.characters, required this.isEditing});
}
