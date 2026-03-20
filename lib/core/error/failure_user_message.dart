import 'package:dio/dio.dart';

import 'failure.dart';

/// Короткий текст для UI при ошибке ИИ (без технических деталей).
String describeCharacterAiGenerationFailureForUser(Failure failure) {
  final msg = failure.message?.trim() ?? '';

  if (_isMissingApiKeyMessage(msg)) {
    return 'Задайте ключ выбранного провайдера: GROQ_API_KEY или OPENROUTER_API_KEY '
        'в .env или --dart-define.';
  }

  // Реальный сбой HTTP/сети — не путать с отказом парсера/валидации черновика ИИ.
  final isNetworkOrHttp =
      failure is ServerFailure || failure.cause is DioException;
  if (isNetworkOrHttp) {
    return 'Ошибка сервера. Попробуйте позже или включите VPN.';
  }

  if (_isParseFailureMessage(msg)) {
    return 'Сервис вернул неожиданный ответ. Попробуйте ещё раз.';
  }

  if (msg.isNotEmpty) {
    return msg;
  }

  return 'Ошибка сервера. Попробуйте позже или включите VPN.';
}

bool _isMissingApiKeyMessage(String m) {
  final lower = m.toLowerCase();
  return lower.contains('groq_api_key') ||
      lower.contains('openrouter_api_key') ||
      (lower.contains('не задан') && lower.contains('ключ'));
}

bool _isParseFailureMessage(String m) {
  final lower = m.toLowerCase();
  return lower.contains('разобрать ответ') ||
      lower.contains('не удалось разобрать');
}

/// Текст для пользователя и для [debugPrint] (ответ API, Dio, причина).
String describeFailureForUser(Failure failure) {
  final parts = <String>[];

  final msg = failure.message?.trim();
  if (msg != null && msg.isNotEmpty) {
    parts.add(msg);
  }

  final cause = failure.cause;
  if (cause is DioException) {
    final code = cause.response?.statusCode;
    parts.add(
      'Сеть: ${cause.type.name}${code != null ? ' · HTTP $code' : ''}',
    );
    final data = cause.response?.data;
    if (data != null) {
      parts.add('Ответ сервера:\n$data');
    } else if (cause.message != null && cause.message!.isNotEmpty) {
      parts.add(cause.message!);
    }
  } else if (cause != null) {
    parts.add('Детали: $cause');
  }

  return parts.isEmpty ? 'Ошибка без описания.' : parts.join('\n\n');
}
