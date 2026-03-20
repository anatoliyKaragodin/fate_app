import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/avatar_ai/domain/repositories/character_avatar_generation_repository.dart';

class GenerateCharacterAvatarParams {
  const GenerateCharacterAvatarParams({
    required this.prompt,
    this.cancelToken,
  });

  final String prompt;
  final CancelToken? cancelToken;
}

class GenerateCharacterAvatar
    extends UseCase<String, GenerateCharacterAvatarParams> {
  GenerateCharacterAvatar(this._repository);

  final CharacterAvatarGenerationRepository _repository;

  @override
  Future<Either<Failure, String>> call(
    GenerateCharacterAvatarParams params,
  ) async {
    final p = params.prompt.trim();
    if (p.isEmpty) {
      return const Left(
        UnknownFailure(message: 'Промпт для картинки пустой.'),
      );
    }
    return _repository.generatePortrait(
      prompt: p,
      cancelToken: params.cancelToken,
    );
  }
}
