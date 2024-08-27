part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterPlayPageState with CharacterPlayPageStateMappable {
  final CharacterEntity character;
  final bool isCompact;
  final List<TextEditingController> consequencesControllers;

  CharacterPlayPageState(
      {required this.character,
      required this.isCompact,
      required this.consequencesControllers});
}
