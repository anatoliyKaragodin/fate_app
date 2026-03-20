import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Ключи из `--dart-define=...` или из `.env` (после [dotenv.load]).
class AiApiKeySource {
  AiApiKeySource._();

  static String groqApiKey() {
    const fromDefine = String.fromEnvironment('GROQ_API_KEY', defaultValue: '');
    final raw = fromDefine.isNotEmpty
        ? fromDefine
        : (dotenv.env['GROQ_API_KEY'] ?? '');
    return _normalizeSecret(raw);
  }

  static String openRouterApiKey() {
    const fromDefine =
        String.fromEnvironment('OPENROUTER_API_KEY', defaultValue: '');
    final raw = fromDefine.isNotEmpty
        ? fromDefine
        : (dotenv.env['OPENROUTER_API_KEY'] ?? '');
    return _normalizeSecret(raw);
  }

  /// Убираем пробелы, BOM, обрамляющие кавычки из .env — иначе API может ответить 403.
  static String _normalizeSecret(String raw) {
    var k = raw.trim();
    if (k.startsWith('\uFEFF')) {
      k = k.substring(1).trim();
    }
    if (k.length >= 2) {
      final q = k[0];
      if ((q == '"' || q == "'") && k[k.length - 1] == q) {
        k = k.substring(1, k.length - 1).trim();
      }
    }
    return k;
  }
}
