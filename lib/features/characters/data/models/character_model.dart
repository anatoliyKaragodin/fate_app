part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CharacterModel with CharacterModelMappable {
  final String?
      remoteId; // Уникальный идентификатор персонажа на удаленном сервере
  final int? localeId; // Идентификатор локальный
  final String name; // Имя персонажа
  final String description; // Описание персонажа
  final String? image; // Путь к изображению персонажа
  final List<SkillModel> skills; // Навыки персонажа
  final String concept; // Концепция персонажа
  final String problem; // Проблема персонажа
  final List<String> aspects; // Аспекты персонажа
  final List<StuntModel> stunts; // Трюки персонажа
  final String? audio; // Путь к аудиофайлу персонажа
  final DateTime? createdAt; // Дата создания персонажа
  final DateTime? updatedAt; // Дата последнего обновления персонажа
  final int? stress; // Уровень стресса персонажа
  final List<String?> consequences; // Последствия действий персонажа
  final int? fateTokens; // Количество жетонов судьбы

  const CharacterModel({
    this.remoteId,
    this.localeId,
    required this.name,
    required this.description,
    this.image,
    required this.skills,
    required this.concept,
    required this.problem,
    required this.aspects,
    required this.stunts,
    this.audio,
    required this.consequences,
    this.createdAt,
    this.fateTokens,
    this.stress,
    this.updatedAt,
  });

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
      consequences: consequences,
      audio: audio,
      createdAt: createdAt,
      updatedAt: updatedAt,
      fateTokens: fateTokens,
      stress: stress,
    );
  }

  Map<String, dynamic> toSQLite() {
    return {
      'remote_id': remoteId,
      'name': name,
      'description': description,
      'image': image,
      'skills': jsonEncode(skills.map((skill) => skill.toMap()).toList()),
      'concept': concept,
      'problem': problem,
      'aspects': jsonEncode(aspects),
      'stunts': jsonEncode(stunts.map((stunt) => stunt.toMap()).toList()),
      'audio': audio,
      'created_at':
          createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'updated_at':
          updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'stress': stress,
      'consequences': jsonEncode(consequences),
      'fate_tokens': fateTokens ?? 3,
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
      stunts:
          entity.stunts.map((stunt) => StuntModel.fromEntity(stunt)).toList(),
      fateTokens: entity.fateTokens,
      audio: entity.audio,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      consequences: entity.consequences,
      stress: entity.stress,
    );
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
      audio: data['audio'],
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      stress: data['stress'],
      consequences: data['consequences'] != null
          ? (jsonDecode(data['consequences']) as List).cast<String?>()
          : [null, null, null],
      fateTokens: data['fate_tokens'],
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
    final consequences = List.generate(3, (i) => 'consequence$i');

    return CharacterModel(
        name: 'name$index',
        description: '$index',
        skills: skills,
        concept: 'concept$index',
        problem: 'problem$index',
        aspects: aspects,
        stunts: stunts,
        consequences: consequences,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        stress: 3,
        fateTokens: 3);
  }
}
