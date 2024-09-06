part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharactersListPageState with CharactersListPageStateMappable {
  final List<CharacterEntity> characters;
  final bool isEditing;
  final SortType sortType;

  const CharactersListPageState(
      {required this.characters,
      required this.isEditing,
      required this.sortType});
}
