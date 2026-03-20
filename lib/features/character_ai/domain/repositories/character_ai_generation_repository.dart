import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_field_regen_patch.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';

abstract class CharacterAiGenerationRepository {
  Future<Either<Failure, CharacterAiDraft>> generateDraft({
    required String userHint,
    required AiProvider provider,
    required String apiKey,
  });

  /// Перегенерация одного поля; [sheetContext] — краткий текст текущего листа (формирует UI/VM).
  Future<Either<Failure, CharacterFieldRegenPatch>> generateFieldRegen({
    required CharacterRegenField field,
    required String userHint,
    required String sheetContext,
    required AiProvider provider,
    required String apiKey,
    String? stuntTypeLabel,
  });
}
