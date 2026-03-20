import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';

class GenerateCharacterDraftParams {
  final String userHint;

  const GenerateCharacterDraftParams({required this.userHint});
}

class GenerateCharacterDraft
    extends UseCase<CharacterAiDraft, GenerateCharacterDraftParams> {
  final AiSettingsRepository _settings;
  final CharacterAiGenerationRepository _generation;

  GenerateCharacterDraft(this._settings, this._generation);

  @override
  Future<Either<Failure, CharacterAiDraft>> call(
    GenerateCharacterDraftParams params,
  ) async {
    dev.log('[AI] use case: провайдер и ключ…');
    final provider = await _settings.getSelectedProvider();
    final key = await _settings.getApiKey(provider);
    if (key == null || key.trim().isEmpty) {
      dev.log('[AI] use case: ключ пуст — отмена');
      final hint = switch (provider) {
        AiProvider.openRouter =>
          'Не задан OPENROUTER_API_KEY: --dart-define или .env (в CI — секрет).',
        _ =>
          'Не задан GROQ_API_KEY: --dart-define или .env (в CI — секрет).',
      };
      return Left(UnknownFailure(message: hint));
    }
    dev.log('[AI] use case: запрос в репозиторий (${provider.name})…');
    final out = await _generation.generateDraft(
      userHint: params.userHint,
      provider: provider,
      apiKey: key.trim(),
    );
    dev.log('[AI] use case: ответ репозитория получен');
    return out;
  }
}
