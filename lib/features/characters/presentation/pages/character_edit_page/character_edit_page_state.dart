part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterEditPageState with CharacterEditPageStateMappable {
  final CharacterEntity character;
  final List<int?> skillAvailableList;

  const CharacterEditPageState(
      {required this.character, required this.skillAvailableList});
}
