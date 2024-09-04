part of 'mapper/entities_mapper.dart';

@MappableClass()
class RollResultEntity with RollResultEntityMappable {
  final DateTime date;
  final SkillEntity skill;
  final int result;
  final int successes;
  final int fails;

  RollResultEntity(
      {required this.date,
      required this.skill,
      required this.result,
      required this.successes,
      required this.fails});
}
