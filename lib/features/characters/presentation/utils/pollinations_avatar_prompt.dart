import 'package:fate_app/features/avatar_ai/data/pollinations_prompt_ascii.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';

/// Промпт для аватара (SiliconFlow): префикс на EN + **имя**, **концепт** и **описание**
/// в латинице. Проблема в промпт не включается.
///
/// В блок **description** попадает [CharacterEntity.description] — поле «Описание» на листе.
String buildPollinationsAvatarPrompt(CharacterEntity character) {
  var name = character.name.trim();
  const maxNameForImage = 80;
  if (name.length > maxNameForImage) {
    name = '${name.substring(0, maxNameForImage)}…';
  }

  final concept = character.concept.trim();
  var description = character.description.trim();
  // Короче описание — стабильнее и дешевле по токенам/времени генерации.
  const maxDescriptionForImage = 220;
  if (description.length > maxDescriptionForImage) {
    description = '${description.substring(0, maxDescriptionForImage)}…';
  }

  final parts = <String>[
    'square portrait head shoulders clear face digital illustration character',
    if (name.isNotEmpty) 'character name ${pollinationsAsciiPrompt(name)}',
    if (concept.isNotEmpty) 'concept ${pollinationsAsciiPrompt(concept)}',
    if (description.isNotEmpty)
      'description ${pollinationsAsciiPrompt(description)}',
  ];

  var s = parts.join(', ');
  const maxLen = 360;
  if (s.length > maxLen) {
    s = s.substring(0, maxLen);
  }
  return s.replaceAll(RegExp(r'\s+'), ' ').trim();
}

bool hasPollinationsAvatarPromptMaterial(CharacterEntity character) {
  return character.name.trim().isNotEmpty ||
      character.concept.trim().isNotEmpty ||
      character.description.trim().isNotEmpty;
}
