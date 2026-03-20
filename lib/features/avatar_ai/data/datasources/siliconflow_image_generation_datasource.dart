import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:fate_app/core/error/exception.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/avatar_ai/data/siliconflow_avatar_config.dart';

/// POST `/v1/images/generations`, затем скачивание по временному URL.
class SiliconFlowImageGenerationDataSource {
  SiliconFlowImageGenerationDataSource(this._dio);

  final Dio _dio;

  Future<List<int>> generatePortraitBytes({
    required String imagePrompt,
    required String apiKey,
    CancelToken? cancelToken,
  }) async {
    final uri = Uri.parse('${SiliconFlowAvatarConfig.baseUrl}/images/generations');
    final model = SiliconFlowAvatarConfig.model;
    final wrapped =
        'Square character portrait, head and shoulders, clear face, digital '
        'illustration. $imagePrompt';

    final payload = <String, dynamic>{
      'model': model,
      'prompt': wrapped,
      'image_size': SiliconFlowAvatarConfig.imageSize,
      if (model.contains('FLUX.1-schnell')) 'prompt_enhancement': false,
    };

    dev.log(
      'SiliconFlow: POST images/generations · model=$model · size=${SiliconFlowAvatarConfig.imageSize}',
      name: 'SiliconFlowAvatar',
    );

    try {
      final sw = Stopwatch()..start();
      final response = await _dio.postUri<Map<String, dynamic>>(
        uri,
        data: jsonEncode(payload),
        cancelToken: cancelToken,
        options: Options(
          method: 'POST',
          receiveTimeout: const Duration(seconds: 180),
          headers: <String, dynamic>{
            Headers.contentTypeHeader: Headers.jsonContentType,
            Headers.acceptHeader: Headers.jsonContentType,
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );
      sw.stop();
      dev.log(
        'SiliconFlow: generations ${sw.elapsedMilliseconds} ms · HTTP ${response.statusCode}',
        name: 'SiliconFlowAvatar',
      );

      final data = response.data;
      if (data == null) {
        throw const ServerException(message: 'SiliconFlow: пустой JSON');
      }

      final url = _parseImageUrl(data);
      dev.log(
        'SiliconFlow: скачивание картинки…',
        name: 'SiliconFlowAvatar',
      );

      final img = await _dio.get<List<int>>(
        url,
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 120),
        ),
      );

      final bytes = img.data;
      if (bytes == null || bytes.isEmpty) {
        throw const ServerException(message: 'SiliconFlow: пустой файл изображения');
      }
      dev.log(
        'SiliconFlow: OK · ${bytes.length} байт',
        name: 'SiliconFlowAvatar',
      );
      return bytes;
    } on DioException catch (e, st) {
      if (e.type == DioExceptionType.cancel) {
        throw OperationCancelledFailure(cause: e);
      }
      dev.log(
        'SiliconFlow: Dio ${e.type.name} · ${e.response?.statusCode} · ${e.message}',
        name: 'SiliconFlowAvatar',
        error: e,
        stackTrace: st,
      );
      final msg = _errorMessage(e.response?.data) ??
          e.message ??
          'SiliconFlow: сеть';
      throw ServerException(message: msg, cause: e);
    }
  }

  static String _parseImageUrl(Map<String, dynamic> data) {
    final images = data['images'];
    if (images is! List || images.isEmpty) {
      throw ServerException(
        message: 'SiliconFlow: в ответе нет images: ${data.keys.join(", ")}',
      );
    }
    final first = images.first;
    if (first is! Map) {
      throw const ServerException(message: 'SiliconFlow: неверный images[0]');
    }
    final url = first['url'];
    if (url is! String || url.isEmpty) {
      throw const ServerException(message: 'SiliconFlow: нет url у изображения');
    }
    return url;
  }

  static String? _errorMessage(Object? body) {
    if (body is! Map) return body?.toString();
    final err = body['error'];
    if (err is Map && err['message'] != null) {
      return err['message'].toString();
    }
    if (err is String) return err;
    return body['message']?.toString();
  }
}
