import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_field_regen_patch.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';

class RegenerateCharacterFieldParams {
  const RegenerateCharacterFieldParams({
    required this.field,
    required this.userHint,
    required this.sheetContext,
    this.stuntTypeLabel,
  });

  final CharacterRegenField field;
  final String userHint;
  final String sheetContext;
  final String? stuntTypeLabel;
}

class RegenerateCharacterField
    extends UseCase<CharacterFieldRegenPatch, RegenerateCharacterFieldParams> {
  RegenerateCharacterField(this._settings, this._generation);

  final AiSettingsRepository _settings;
  final CharacterAiGenerationRepository _generation;

  @override
  Future<Either<Failure, CharacterFieldRegenPatch>> call(
    RegenerateCharacterFieldParams params,
  ) async {
    final provider = await _settings.getSelectedProvider();
    final key = await _settings.getApiKey(provider);
    if (key == null || key.trim().isEmpty) {
      final hint = switch (provider) {
        AiProvider.openRouter =>
          'Не задан OPENROUTER_API_KEY: --dart-define или .env (в CI — секрет).',
        AiProvider.groq =>
          'Не задан GROQ_API_KEY: --dart-define или .env (в CI — секрет).',
      };
      return Left(UnknownFailure(message: hint));
    }
    return _generation.generateFieldRegen(
      field: params.field,
      userHint: params.userHint,
      sheetContext: params.sheetContext,
      provider: provider,
      apiKey: key.trim(),
      stuntTypeLabel: params.stuntTypeLabel,
    );
  }
}
