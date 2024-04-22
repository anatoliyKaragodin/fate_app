part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterPageState with CharacterPageStateMappable {
  final CharacterEntity character;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  final TextEditingController conceptController;
  final TextEditingController problemController;
  final List<TextEditingController> aspectsControllers;

  final List<int?> skills;

  final List<TextEditingController> stuntsControllers;

  const CharacterPageState({
    required this.character,
    required this.nameController,
    required this.descriptionController,
    required this.conceptController,
    required this.problemController,
    required this.aspectsControllers,
    required this.skills,
    required this.stuntsControllers,
  });
}
