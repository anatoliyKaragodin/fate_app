/// Ограничения длины полей — совпадают с [maxLength] в UI редактора персонажа.
/// Для ИИ те же числа задаются в системном промпте; обрезки в коде нет.
abstract final class CharacterFieldLimits {
  static const int name = 100;
  static const int concept = 100;
  static const int problem = 100;

  /// Единое поле «Описание» в приложении (после слияния внешности и текста).
  static const int description = 500;

  static const int aspect = 100;
  static const int stuntDescription = 100;
}

/// Склеивает внешность и описание в одну строку для листа (без обрезки).
String mergeAppearanceIntoDescription({
  required String appearance,
  required String descriptionBody,
}) {
  final app = appearance.trim();
  final body = descriptionBody.trim();
  const prefix = 'Внешность: ';
  if (app.isEmpty) {
    return body;
  }
  if (body.isEmpty) {
    return '$prefix$app';
  }
  return '$prefix$app\n\n$body';
}
