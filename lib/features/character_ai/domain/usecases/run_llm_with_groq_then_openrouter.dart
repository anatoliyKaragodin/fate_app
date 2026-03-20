import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';

typedef LlmInvoke<T> = Future<Either<Failure, T>> Function(
  AiProvider provider,
  String apiKey,
);

/// Сначала Groq (если задан `GROQ_API_KEY`), при любой ошибке кроме отмены —
/// повтор через OpenRouter при наличии `OPENROUTER_API_KEY`.
/// Без ключа Groq сразу OpenRouter; нужен хотя бы один из ключей.
Future<Either<Failure, T>> runLlmWithGroqThenOpenRouter<T>({
  required AiSettingsRepository settings,
  required LlmInvoke<T> invoke,
}) async {
  final groqKey = (await settings.getApiKey(AiProvider.groq))?.trim();
  final orKey = (await settings.getApiKey(AiProvider.openRouter))?.trim();

  if ((groqKey == null || groqKey.isEmpty) &&
      (orKey == null || orKey.isEmpty)) {
    return const Left(
      UnknownFailure(
        message:
            'Задайте хотя бы один ключ: GROQ_API_KEY или OPENROUTER_API_KEY '
            'в .env или --dart-define.',
      ),
    );
  }

  if (groqKey != null && groqKey.isNotEmpty) {
    dev.log('[AI] цепочка: запрос через Groq…');
    final first = await invoke(AiProvider.groq, groqKey);
    return first.fold<Future<Either<Failure, T>>>(
      (f) async {
        if (f is OperationCancelledFailure) {
          dev.log('[AI] цепочка: отмена — OpenRouter не вызываем');
          return Left(f);
        }
        dev.log(
          '[AI] цепочка: ошибка Groq (${f.runtimeType}) — пробуем OpenRouter…',
        );
        if (orKey == null || orKey.isEmpty) {
          return Left(f);
        }
        return invoke(AiProvider.openRouter, orKey);
      },
      (value) async => Right(value),
    );
  }

  dev.log('[AI] цепочка: ключа Groq нет — сразу OpenRouter');
  return invoke(AiProvider.openRouter, orKey!);
}
