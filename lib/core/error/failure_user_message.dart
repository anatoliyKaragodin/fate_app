import 'package:dio/dio.dart';

import 'failure.dart';

/// Тело ответа Dio: при [ResponseType.bytes] приходит [List<int>] (UTF-8), не «мусор».
String formatDioResponseBodyForLog(Object? data) {
  if (data == null) return '(пусто)';
  if (data is List<int>) {
    if (data.isEmpty) return '(пусто)';
    try {
      return String.fromCharCodes(data);
    } on Object catch (_) {
      return '(не UTF-8, ${data.length} байт)';
    }
  }
  return data.toString();
}

/// Короткий текст для UI при ошибке ИИ (без технических деталей).
String describeCharacterAiGenerationFailureForUser(Failure failure) {
  final msg = failure.message?.trim() ?? '';

  if (_isMissingApiKeyMessage(msg)) {
    return 'Задайте хотя бы один ключ: GROQ_API_KEY и/или OPENROUTER_API_KEY '
        'в .env или --dart-define (сначала Groq, при ошибке — OpenRouter).';
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

/// Сообщение для UI при ошибке генерации аватара (SiliconFlow).
String describeAvatarGenerationFailureForUser(Failure failure) {
  final msg = failure.message?.trim() ?? '';

  if (_isMissingApiKeyMessage(msg)) {
    return 'Задайте SILICONFLOW_API_KEY в .env или через --dart-define.';
  }

  final isNetworkOrHttp =
      failure is ServerFailure || failure.cause is DioException;
  if (isNetworkOrHttp) {
    if (failure.cause is DioException) {
      final dio = failure.cause as DioException;
      final code = dio.response?.statusCode;
      if (code == 429) {
        return 'Слишком частые запросы. Подождите немного и попробуйте снова.';
      }
      if (code == 500 || code == 502 || code == 503) {
        return 'Сервер временно недоступен или перегружен. '
            'Попробуйте ещё раз через минуту.';
      }
    }
    return 'Не удалось получить картинку. Проверьте сеть или попробуйте позже.';
  }

  if (failure is CacheFailure) {
    return 'Не удалось сохранить файл аватара на устройстве.';
  }

  if (msg.isNotEmpty) {
    return msg;
  }

  return 'Не удалось сгенерировать аватар.';
}

bool _isMissingApiKeyMessage(String m) {
  final lower = m.toLowerCase();
  return lower.contains('groq_api_key') ||
      lower.contains('openrouter_api_key') ||
      lower.contains('siliconflow_api_key') ||
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
      parts.add('Ответ сервера:\n${formatDioResponseBodyForLog(data)}');
    } else if (cause.message != null && cause.message!.isNotEmpty) {
      parts.add(cause.message!);
    }
  } else if (cause != null) {
    parts.add('Детали: $cause');
  }

  return parts.isEmpty ? 'Ошибка без описания.' : parts.join('\n\n');
}
