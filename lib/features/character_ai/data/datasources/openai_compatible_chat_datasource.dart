import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:fate_app/core/error/failure.dart';
/// Обернуть строку в одинарные кавычки для bash (`'` внутри → `'\''`).
String _bashSingleQuoted(String s) => "'${s.replaceAll("'", r"'\''")}'";

/// OpenAI-совместимый chat completions (Groq, OpenRouter и др.).
///
/// Эквивалент официальному запросу:
/// ```bash
/// curl -X POST "https://api.groq.com/openai/v1/chat/completions" \
///   -H "Authorization: Bearer $GROQ_API_KEY" \
///   -H "Content-Type: application/json" \
///   -d '{"messages":[...], "model":"llama-3.3-70b-versatile"}'
/// ```
///
/// Здесь дополнительно: роль `system` (промпт Fate) и поле `temperature` — Groq это поддерживает.
class OpenAiCompatibleChatDataSource {
  OpenAiCompatibleChatDataSource(this._dio);

  final Dio _dio;

  Future<String> completeChat({
    required String baseUrl,
    required String apiKey,
    required String model,
    required String system,
    required String user,
    Map<String, String> extraHeaders = const {},
  }) async {
    // Ровно как в curl из доки Groq: POST + JSON body (не GET).
    // Редиректы 30x иногда превращают POST в GET — отключаем.
    final uri = Uri.parse(
      baseUrl.endsWith('/')
          ? '${baseUrl}chat/completions'
          : '$baseUrl/chat/completions',
    );
    // Как в curl: messages + model (порядок ключей не важен для API).
    final payload = <String, dynamic>{
      'messages': [
        {'role': 'system', 'content': system},
        {'role': 'user', 'content': user},
      ],
      'model': model,
      'temperature': 0.7,
    };
    _logPostmanCurl(uri: uri, payload: payload);

    try {
      dev.log('[AI] Dio POST начало: $uri model=$model');
      final sw = Stopwatch()..start();
      final response = await _dio.postUri<Map<String, dynamic>>(
        uri,
        data: jsonEncode(payload),
        options: Options(
          method: 'POST',
          followRedirects: false,
          headers: <String, dynamic>{
            ...extraHeaders,
            Headers.acceptHeader: Headers.jsonContentType,
            Headers.contentTypeHeader: Headers.jsonContentType,
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      sw.stop();
      dev.log('[AI] Dio POST завершён за ${sw.elapsedMilliseconds} ms, status=${response.statusCode}');
      _logResponseBody('[AI] Ответ сервера', response.data);
      final content = _readContent(response.data);
      if (content == null || content.isEmpty) {
        dev.log('[AI] пустой content в choices');
        throw const FormatException('empty model content');
      }
      return content;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        _logResponseBody('[AI] Ответ сервера при ошибке', e.response!.data);
      }
      dev.log(
        '[AI] DioException method=${e.requestOptions.method} uri=${e.requestOptions.uri} '
        'type=${e.type} message=${e.message} status=${e.response?.statusCode}',
        error: e,
        stackTrace: e.stackTrace,
      );
      final msg = _groqOrOpenAiErrorMessage(e.response?.data) ??
          e.message ??
          'Ошибка сети';
      throw ServerFailure(message: msg, cause: e);
    }
  }

  static void _logResponseBody(String prefix, Object? data) {
    if (data == null) {
      dev.log('$prefix: (пусто)');
      return;
    }
    if (data is String) {
      dev.log('$prefix:\n$data');
      return;
    }
    try {
      final text = data is Map
          ? const JsonEncoder.withIndent('  ').convert(data)
          : data is List
              ? const JsonEncoder.withIndent('  ').convert(data)
              : data.toString();
      dev.log('$prefix:\n$text');
    } on Object catch (_) {
      dev.log('$prefix: $data');
    }
  }

  /// Один curl для Postman: Import → Raw text (одна строка).
  static void _logPostmanCurl({
    required Uri uri,
    required Map<String, dynamic> payload,
  }) {
    final bodyCompact = jsonEncode(payload);

    final urlQ = _bashSingleQuoted(uri.toString());
    final authQ = _bashSingleQuoted(r'Authorization: Bearer $API_KEY');
    final ctQ = _bashSingleQuoted('Content-Type: application/json');
    final acceptQ = _bashSingleQuoted('Accept: application/json');
    final dataQ = _bashSingleQuoted(bodyCompact);

    final postmanCurl = [
      'curl',
      '--location',
      urlQ,
      '--request',
      'POST',
      '--header',
      authQ,
      '--header',
      ctQ,
      '--header',
      acceptQ,
      '--data-raw',
      dataQ,
    ].join(' ');
    dev.log(postmanCurl, name: 'postman_curl');
    dev.log(
      '[AI] Postman: File → Import → Raw text — вставьте строку из лога «postman_curl» '
      '(целиком, одна строка). В заголовке Authorization подставьте ключ '
      '(GROQ_API_KEY или OPENROUTER_API_KEY).',
      name: 'postman_curl_hint',
    );
  }

  /// Groq: `{ "error": { "message": "...", "type": "..." } }`; OpenAI — похоже.
  static String? _groqOrOpenAiErrorMessage(Object? body) {
    if (body is! Map) return body?.toString();
    final err = body['error'];
    if (err is Map && err['message'] != null) {
      return err['message'].toString();
    }
    if (err != null) return err.toString();
    return body['message']?.toString();
  }

  String? _readContent(Map<String, dynamic>? data) {
    final choices = data?['choices'];
    if (choices is! List || choices.isEmpty) return null;
    final first = choices.first;
    if (first is! Map) return null;
    final message = first['message'];
    if (message is! Map) return null;
    return message['content'] as String?;
  }
}
