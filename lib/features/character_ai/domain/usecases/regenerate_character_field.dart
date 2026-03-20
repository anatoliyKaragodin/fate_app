import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_field_regen_patch.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';
import 'package:fate_app/features/character_ai/domain/usecases/run_llm_with_groq_then_openrouter.dart';

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
    return runLlmWithGroqThenOpenRouter<CharacterFieldRegenPatch>(
      settings: _settings,
      invoke: (provider, apiKey) => _generation.generateFieldRegen(
        field: params.field,
        userHint: params.userHint,
        sheetContext: params.sheetContext,
        provider: provider,
        apiKey: apiKey,
        stuntTypeLabel: params.stuntTypeLabel,
      ),
    );
  }
}
