part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CharacterModel with CharacterModelMappable {
  final String? remoteId;
  final int? localeId;
  final String name;
  final String description;
  final String? image;
  final List<int> skills;
  final String concept;
  final String problem;
  final List<String> aspects;
  final List<String> stunts;

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
      skills: skills,
      concept: concept,
      problem: problem,
      aspects: aspects,
      stunts: stunts,
    );
  }

  Map<String, dynamic> toSQLite() {
    return {
      'remote_id': remoteId,
      'locale_id': localeId,
      'name': name,
      'description': description,
      'image': image,
      'skills': jsonEncode(skills),
      'concept': concept,
      'problem': problem,
      'aspects': jsonEncode(aspects),
      'stunts': jsonEncode(stunts),
    };
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
        remoteId: entity.remoteId,
        localeId: entity.localeId,
        name: entity.name,
        description: entity.description,
        image: entity.image,
        skills: entity.skills,
        concept: entity.concept,
        problem: entity.problem,
        aspects: entity.aspects,
        stunts: entity.stunts);
  }

  factory CharacterModel.fromSQLite(Map<String, dynamic> data) {
    return CharacterModel(
      remoteId: data['remote_id'],
      localeId: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      skills: jsonDecode(data['skills']).cast<int>(),
      concept: data['concept'],
      problem: data['problem'],
      aspects: jsonDecode(data['aspects']).cast<String>(),
      stunts: jsonDecode(data['stunts']).cast<String>(),
    );
  }
}
