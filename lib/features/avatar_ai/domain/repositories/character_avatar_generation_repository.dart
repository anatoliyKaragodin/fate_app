import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fate_app/core/error/failure.dart';

/// Генерация портрета персонажа через SiliconFlow Images API и сохранение локально.
abstract class CharacterAvatarGenerationRepository {
  Future<Either<Failure, String>> generatePortrait({
    required String prompt,
    CancelToken? cancelToken,
  });
}
