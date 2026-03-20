import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';
import 'package:fate_app/features/character_ai/domain/usecases/run_llm_with_groq_then_openrouter.dart';

class GenerateCharacterDraftParams {
  final String userHint;
  final CancelToken? cancelToken;

  const GenerateCharacterDraftParams({
    required this.userHint,
    this.cancelToken,
  });
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
    dev.log('[AI] use case: Groq → OpenRouter при сбое…');
    final out = await runLlmWithGroqThenOpenRouter<CharacterAiDraft>(
      settings: _settings,
      invoke: (provider, apiKey) => _generation.generateDraft(
        userHint: params.userHint,
        provider: provider,
        apiKey: apiKey,
        cancelToken: params.cancelToken,
      ),
    );
    dev.log('[AI] use case: ответ репозитория получен');
    return out;
  }
}
