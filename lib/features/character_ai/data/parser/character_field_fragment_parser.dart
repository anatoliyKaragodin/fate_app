import 'dart:convert';

/// Разбор ответа ИИ для точечной генерации (не полный лист).
class CharacterFieldFragmentParser {
  CharacterFieldFragmentParser._();

  static String stripCodeFence(String s) {
    var t = s.trim();
    if (t.startsWith('```')) {
      final firstNl = t.indexOf('\n');
      if (firstNl != -1) {
        t = t.substring(firstNl + 1);
      }
      final end = t.lastIndexOf('```');
      if (end != -1) {
        t = t.substring(0, end);
      }
    }
    return t.trim();
  }

  /// Одна строка текста без кавычек и лишних переносов.
  static String parsePlainLine(String raw) {
    var t = stripCodeFence(raw);
    t = t.replaceAll('\r\n', '\n');
    final firstLine = t.split('\n').map((e) => e.trim()).firstWhere(
          (e) => e.isNotEmpty,
          orElse: () => t.trim(),
        );
    t = firstLine;
    if ((t.startsWith('"') && t.endsWith('"')) ||
        (t.startsWith('«') && t.endsWith('»'))) {
      t = t.substring(1, t.length - 1).trim();
    }
    return t.trim();
  }

  /// JSON `{"appearance":"","description":""}` → склеенное описание для листа.
  static String parseDescriptionFragment(String raw) {
    final jsonText = stripCodeFence(raw);
    final decoded = jsonDecode(jsonText);
    if (decoded is! Map) {
      throw const FormatException('description fragment not a JSON object');
    }
    final map = Map<String, dynamic>.from(decoded);
    final appearance = (map['appearance'] ?? '').toString().trim();
    final body = (map['description'] ?? '').toString().trim();
    const prefix = 'Внешность: ';
    if (appearance.isEmpty) {
      return body;
    }
    if (body.isEmpty) {
      return '$prefix$appearance';
    }
    return '$prefix$appearance\n\n$body';
  }
}
