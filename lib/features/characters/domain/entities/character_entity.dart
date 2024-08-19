part of '../mapper/entities_mapper.dart';

@MappableClass()
class CharacterEntity with CharacterEntityMappable {
  final String? remoteId;
  final int? localeId;
  final String name;
  final String description;
  final String? image;
  final List<SkillEntity> skills;
  final String concept;
  final String problem;
  final List<String> aspects;
  final List<StuntEntity> stunts;

  const CharacterEntity(
      {this.remoteId,
      this.localeId,
      required this.name,
      required this.description,
      this.image,
      required this.skills,
      required this.concept,
      required this.problem,
      required this.aspects,
      required this.stunts});

  factory CharacterEntity.empty() {
    final skills = List.generate(SkillType.values.length,
        (index) => SkillEntity(type: SkillType.values[index]));

    final stunts = [
      StuntEntity(type: StuntType.oneTime),
      StuntEntity(type: StuntType.oneTime),
      StuntEntity(type: StuntType.oneTime)
    ];

    return CharacterEntity(
      name: '',
      description: '',
      skills: skills,
      concept: '',
      problem: '',
      aspects: ['', '', ''],
      stunts: stunts,
    );
  }
}
