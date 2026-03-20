import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fate_app/core/error/exception.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/avatar_ai/data/datasources/siliconflow_image_generation_datasource.dart';
import 'package:fate_app/features/avatar_ai/domain/repositories/character_avatar_generation_repository.dart';
import 'package:fate_app/features/character_ai/data/ai_api_key_source.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';

class CharacterAvatarGenerationRepositoryImpl
    implements CharacterAvatarGenerationRepository {
  CharacterAvatarGenerationRepositoryImpl(this._siliconFlow, this._files);

  final SiliconFlowImageGenerationDataSource _siliconFlow;
  final FileRepository _files;

  @override
  Future<Either<Failure, String>> generatePortrait({
    required String prompt,
    CancelToken? cancelToken,
  }) async {
    final sfKey = AiApiKeySource.siliconFlowApiKey().trim();

    dev.log(
      'repo: старт · prompt=${prompt.length} симв. · SiliconFlow key=${sfKey.isNotEmpty}',
      name: 'AvatarGen',
    );
    dev.log('repo: промпт:\n$prompt', name: 'AvatarGen');

    if (sfKey.isEmpty) {
      return const Left(
        ServerFailure(
          message:
              'Не задан SILICONFLOW_API_KEY — добавьте в .env или --dart-define.',
        ),
      );
    }

    try {
      final bytes = await _siliconFlow.generatePortraitBytes(
        imagePrompt: prompt,
        apiKey: sfKey,
        cancelToken: cancelToken,
      );
      final name =
          'avatar_${DateTime.now().millisecondsSinceEpoch}.${_imageExtension(bytes)}';
      return _files.saveImageBytes(bytes, fileName: name);
    } on OperationCancelledFailure catch (e) {
      dev.log('repo: SiliconFlow отмена', name: 'AvatarGen');
      return Left(e);
    } on ServerException catch (e) {
      dev.log('repo: SiliconFlow · ${e.message}', name: 'AvatarGen');
      return Left(ServerFailure(message: e.message, cause: e.cause));
    } catch (e, st) {
      dev.log(
        'repo: SiliconFlow исключение · $e',
        name: 'AvatarGen',
        error: e,
        stackTrace: st,
      );
      return Left(
        UnknownFailure(
          message: 'Не удалось сгенерировать аватар.',
          cause: e,
        ),
      );
    }
  }

  static String _imageExtension(List<int> bytes) {
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'png';
    }
    if (bytes.length >= 3 &&
        bytes[0] == 0xFF &&
        bytes[1] == 0xD8 &&
        bytes[2] == 0xFF) {
      return 'jpg';
    }
    return 'png';
  }
}
