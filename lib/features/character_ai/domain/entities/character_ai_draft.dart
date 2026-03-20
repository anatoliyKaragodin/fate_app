import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

/// Черновик полей персонажа из ответа LLM (до сохранения в БД).
///
/// [appearance] и текстовая часть [description] при применении сливаются в одно поле
/// «Описание» в листе (см. [mergeAppearanceIntoDescription]).
class CharacterAiDraft {
  final String name;
  final String concept;
  final String problem;

  /// Внешность (отдельно от прочего описания); в UI попадает в начало поля «Описание».
  final String appearance;

  /// Описание характера, предыстории и т.п. (без внешности).
  final String description;
  final List<String> aspects;
  final Map<SkillType, int> skills;
  final List<({StuntType type, String description})> stunts;

  const CharacterAiDraft({
    required this.name,
    required this.concept,
    required this.problem,
    required this.appearance,
    required this.description,
    required this.aspects,
    required this.skills,
    required this.stunts,
  });
}
