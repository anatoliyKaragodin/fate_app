part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CharacterModel with CharacterModelMappable {
  final String? remoteId;
  final int? localeId;
  final String name;
  final String description;
  final String? image;
  final List<SkillModel> skills;
  final String concept;
  final String problem;
  final List<String> aspects;
  final List<StuntModel> stunts;

  const CharacterModel(
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

  CharacterEntity toEntity() {
    return CharacterEntity(
      remoteId: remoteId,
      localeId: localeId,
      name: name,
      description: description,
      image: image,
      skills: skills.map((skill) => skill.toEntity()).toList(),
      concept: concept,
      problem: problem,
      aspects: aspects,
      stunts: stunts.map((stunt) => stunt.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toSQLite() {
    return {
      'remote_id': remoteId,
      'locale_id': localeId,
      'name': name,
      'description': description,
      'image': image,
      'skills': jsonEncode(skills.map((skill) => skill.toMap()).toList()),
      'concept': concept,
      'problem': problem,
      'aspects': jsonEncode(aspects),
      'stunts': jsonEncode(stunts.map((stunt) => stunt.toMap()).toList()),
    };
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
        remoteId: entity.remoteId,
        localeId: entity.localeId,
        name: entity.name,
        description: entity.description,
        image: entity.image,
        skills:
            entity.skills.map((skill) => SkillModel.fromEntity(skill)).toList(),
        concept: entity.concept,
        problem: entity.problem,
        aspects: entity.aspects,
        stunts: entity.stunts
            .map((stunt) => StuntModel.fromEntity(stunt))
            .toList());
  }

  factory CharacterModel.fromSQLite(Map<String, dynamic> data) {
    return CharacterModel(
      remoteId: data['remote_id'],
      localeId: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      skills: (jsonDecode(data['skills']) as List)
          .map((skillData) => SkillModel.fromSQLite(skillData))
          .toList(),
      concept: data['concept'],
      problem: data['problem'],
      aspects: (jsonDecode(data['aspects']) as List).cast<String>(),
      stunts: (jsonDecode(data['stunts']) as List)
          .map((stuntData) => StuntModel.fromSQLite(stuntData))
          .toList(),
    );
  }

  factory CharacterModel.empty(int index) {
    final skills = List.generate(
        6, (i) => SkillModel(type: SkillType.values[i], value: i));
    final aspects = List.generate(3, (i) => 'aspect$i');
    final stunts = List.generate(
        3,
        (i) => StuntModel(
            type: StuntType.values[i], description: 'stunt description$i'));

    return CharacterModel(
        name: 'name$index',
        description: '$index',
        skills: skills,
        concept: 'concept$index',
        problem: 'problem$index',
        aspects: aspects,
        stunts: stunts);
  }
}
