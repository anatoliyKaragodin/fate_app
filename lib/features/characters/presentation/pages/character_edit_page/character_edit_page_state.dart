part of '../../mapper/state_mapper.dart';

@MappableClass()
class CharacterEditPageState with CharacterEditPageStateMappable {
  final CharacterEntity character;
  // final List<int?> skills;
  final List<int?> skillAvailableList;
  final TextEditingController nameController;
  final TextEditingController conceptController;
  final TextEditingController problemController;
  final TextEditingController descriptionController;
  final List<TextEditingController> aspectControllers;
  final List<TextEditingController> stuntControllers;

  const CharacterEditPageState(
      {required this.character,
      // required this.skills,
      required this.skillAvailableList,
      required this.aspectControllers,
      required this.conceptController,
      required this.descriptionController,
      required this.nameController,
      required this.problemController,
      required this.stuntControllers});
}
