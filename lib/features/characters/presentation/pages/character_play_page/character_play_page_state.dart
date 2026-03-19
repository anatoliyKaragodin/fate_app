part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterPlayPageState with CharacterPlayPageStateMappable {
  final CharacterEntity character;
  final bool isCompact;
  final bool isScreenLocked;
  final bool isDiceRollShown;
  final List<RollResultEntity> rollResults;

  CharacterPlayPageState(
      {required this.character,
      required this.isCompact,
      required this.isScreenLocked,
      required this.isDiceRollShown,
      required this.rollResults});
}
