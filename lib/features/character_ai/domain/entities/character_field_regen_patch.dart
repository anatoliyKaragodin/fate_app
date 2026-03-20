import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';

/// Одно сгенерированное значение для подстановки в лист.
class CharacterFieldRegenPatch {
  const CharacterFieldRegenPatch({
    required this.field,
    required this.text,
  });

  final CharacterRegenField field;

  /// Для [CharacterRegenField.description] — уже склеенное поле «Описание» (внешность + текст).
  final String text;
}
