part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterPageState with CharacterPageStateMappable {
  final CharacterEntity character;
  final List<int> skills;

  const CharacterPageState({
    required this.character,
    required this.skills,
  });
}
