/// Поле листа, которое можно перегенерировать отдельным запросом к ИИ.
enum CharacterRegenField {
  name,
  concept,
  problem,
  description,
  aspect0,
  aspect1,
  aspect2,
  stunt0,
  stunt1,
  stunt2,
}

extension CharacterRegenFieldX on CharacterRegenField {
  String get uiLabel => switch (this) {
        CharacterRegenField.name => 'Имя',
        CharacterRegenField.concept => 'Концепт',
        CharacterRegenField.problem => 'Проблема',
        CharacterRegenField.description => 'Описание',
        CharacterRegenField.aspect0 => 'Аспект 1',
        CharacterRegenField.aspect1 => 'Аспект 2',
        CharacterRegenField.aspect2 => 'Аспект 3',
        CharacterRegenField.stunt0 => 'Трюк 1',
        CharacterRegenField.stunt1 => 'Трюк 2',
        CharacterRegenField.stunt2 => 'Трюк 3',
      };

  int? get aspectIndex => switch (this) {
        CharacterRegenField.aspect0 => 0,
        CharacterRegenField.aspect1 => 1,
        CharacterRegenField.aspect2 => 2,
        _ => null,
      };

  int? get stuntIndex => switch (this) {
        CharacterRegenField.stunt0 => 0,
        CharacterRegenField.stunt1 => 1,
        CharacterRegenField.stunt2 => 2,
        _ => null,
      };
}
