import 'dart:developer' as dev;

import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/character_ai/data/datasources/openai_compatible_chat_datasource.dart';
import 'package:fate_app/features/character_ai/data/llm/llm_provider_config.dart';
import 'package:fate_app/features/character_ai/data/parser/character_ai_draft_parser.dart';
import 'package:fate_app/features/character_ai/data/parser/character_field_fragment_parser.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_field_regen_patch.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';
import 'package:fate_app/features/characters/domain/character_field_limits.dart';

class CharacterAiGenerationRepositoryImpl
    implements CharacterAiGenerationRepository {
  CharacterAiGenerationRepositoryImpl(this._remote);

  final OpenAiCompatibleChatDataSource _remote;

  static String get _systemPrompt => '''
Ты помогаешь создать персонажа для настольной RPG Fate (лист в приложении на русском).
Ответь ТОЛЬКО одним JSON-объектом, без markdown и без текста до или после.

Смысл уровней навыков (целые 0..3): 3 — лучшая (+4 в терминах Fate), 0 — самая низкая из пирамиды (+1).
Пирамида: ровно одно значение 3, два значения 2, два значения 1, одно значение 0 — по одному на каждый ключ навыка.

Ключи навыков (латиница, как в JSON): careful, clever, flashy, forceful, quick, sneaky.

Трюки: ровно 3 объекта. Поле type — одно из: one_time, careful, clever, flashy, forceful, quick, sneaky.
Поле description — краткое описание трюка на русском.

Все пользовательские тексты — на русском.

Обязательно уложись в лимиты длины полей приложения (символы Unicode, не длиннее указанного):
- name, concept, problem: не более ${CharacterFieldLimits.name} символов каждое
- aspects: ровно 3 строки, каждая не более ${CharacterFieldLimits.aspect} символов
- stunts[].description: каждая не более ${CharacterFieldLimits.stuntDescription} символов
- appearance: только внешность (рост, телосложение, лицо, волосы, одежда, приметы, голос)
- description: характер, предыстория, манера, цели; не дублируй appearance
- В приложении appearance и description склеиваются в одно поле с префиксом «Внешность: » и пустой строкой между блоками. Итоговая строка не должна превышать ${CharacterFieldLimits.description} символов — подбери длину appearance и description так, чтобы суммарно (с префиксом и переносами) уложиться.

Схема JSON:
{
  "name": "",
  "concept": "",
  "problem": "",
  "appearance": "",
  "description": "",
  "aspects": ["", "", ""],
  "skills": { "careful": 0, "clever": 0, "flashy": 0, "forceful": 0, "quick": 0, "sneaky": 0 },
  "stunts": [
    { "type": "one_time", "description": "" },
    { "type": "one_time", "description": "" },
    { "type": "one_time", "description": "" }
  ]
}
''';

  @override
  Future<Either<Failure, CharacterAiDraft>> generateDraft({
    required String userHint,
    required AiProvider provider,
    required String apiKey,
  }) async {
    final cfg = LlmProviderConfig.forProvider(provider);
    try {
      dev.log(
          '[AI] HTTP: ${cfg.baseUrl} model=${cfg.defaultModel} hintLen=${userHint.length}');
      final content = await _remote.completeChat(
        baseUrl: cfg.baseUrl,
        apiKey: apiKey,
        model: cfg.defaultModel,
        system: _systemPrompt,
        user: 'Идея или пожелания игрока:\n$userHint',
        extraHeaders: cfg.extraHeaders,
      );
      dev.log('[AI] HTTP: ответ, длина content=${content.length}');
      final parsed = CharacterAiDraftParser.parseModelContent(content);
      dev.log('[AI] парсинг: ${parsed.isRight() ? "ok" : "ошибка"}');
      return parsed;
    } on ServerFailure catch (e) {
      dev.log('[AI] ServerFailure', error: e, stackTrace: StackTrace.current);
      return Left(e);
    } on FormatException catch (e) {
      dev.log('[AI] FormatException', error: e, stackTrace: StackTrace.current);
      return Left(UnknownFailure(
        message: 'Не удалось разобрать ответ ИИ.',
        cause: e,
      ));
    } catch (e, st) {
      dev.log('[AI] прочая ошибка', error: e, stackTrace: st);
      return Left(UnknownFailure(message: 'Ошибка при обращении к ИИ.', cause: e));
    }
  }

  @override
  Future<Either<Failure, CharacterFieldRegenPatch>> generateFieldRegen({
    required CharacterRegenField field,
    required String userHint,
    required String sheetContext,
    required AiProvider provider,
    required String apiKey,
    String? stuntTypeLabel,
  }) async {
    final cfg = LlmProviderConfig.forProvider(provider);
    final system = _fieldSystemPrompt(field, stuntTypeLabel);
    final user = _fieldUserMessage(sheetContext, userHint);
    try {
      dev.log('[AI] field regen: ${field.name}');
      final content = await _remote.completeChat(
        baseUrl: cfg.baseUrl,
        apiKey: apiKey,
        model: cfg.defaultModel,
        system: system,
        user: user,
        extraHeaders: cfg.extraHeaders,
      );
      final text = _parseFieldContent(field, content);
      if (text.isEmpty) {
        return const Left(UnknownFailure(message: 'ИИ вернул пустой текст.'));
      }
      return Right(CharacterFieldRegenPatch(field: field, text: text));
    } on ServerFailure catch (e) {
      return Left(e);
    } on FormatException catch (e) {
      return Left(UnknownFailure(
        message: 'Не удалось разобрать ответ ИИ для этого поля.',
        cause: e,
      ));
    } catch (e, st) {
      dev.log('[AI] field regen error', error: e, stackTrace: st);
      return Left(UnknownFailure(message: 'Ошибка при обращении к ИИ.', cause: e));
    }
  }

  static String _fieldUserMessage(String sheetContext, String userHint) {
    final hint = userHint.trim();
    return '''
Текущее состояние листа:
$sheetContext

Пожелание к перегенерации (можно оставить пустым):
${hint.isEmpty ? '(нет)' : hint}
''';
  }

  static String _fieldSystemPrompt(
    CharacterRegenField field,
    String? stuntTypeLabel,
  ) {
    switch (field) {
      case CharacterRegenField.name:
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
Ответь ТОЛЬКО новым именем персонажа — одна строка, без кавычек, пояснений и markdown.
Не более ${CharacterFieldLimits.name} символов.''';
      case CharacterRegenField.concept:
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
Ответь ТОЛЬКО новым концептом — одна строка, без кавычек, пояснений и markdown.
Не более ${CharacterFieldLimits.concept} символов.''';
      case CharacterRegenField.problem:
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
Ответь ТОЛЬКО новой формулировкой проблемы персонажа — одна строка, без кавычек, пояснений и markdown.
Не более ${CharacterFieldLimits.problem} символов.''';
      case CharacterRegenField.description:
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
Ответь ТОЛЬКО одним JSON-объектом, без markdown и без текста до или после:
{"appearance":"...","description":"..."}
appearance — только внешность; description — характер и предыстория, не дублируй appearance.
Лимиты как в приложении: итог после склейки с префиксом «Внешность: » и переносом не более ${CharacterFieldLimits.description} символов.''';
      case CharacterRegenField.aspect0:
      case CharacterRegenField.aspect1:
      case CharacterRegenField.aspect2:
        final n = field.aspectIndex! + 1;
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
Ответь ТОЛЬКО текстом одного аспекта №$n (короткая формулировка в духе Fate) — одна строка, без кавычек, пояснений и markdown.
Не более ${CharacterFieldLimits.aspect} символов.''';
      case CharacterRegenField.stunt0:
      case CharacterRegenField.stunt1:
      case CharacterRegenField.stunt2:
        final typeInfo = stuntTypeLabel?.trim().isNotEmpty ?? false
            ? 'Тип трюка уже задан в листе: ${stuntTypeLabel!.trim()}. Не меняй тип, только текст описания.'
            : 'Опиши трюк в рамках уже выбранного типа в листе.';
        return '''
Ты помогаешь с листом персонажа Fate (на русском).
$typeInfo
Ответь ТОЛЬКО текстом описания трюка — одна строка, без кавычек, пояснений и markdown.
Не более ${CharacterFieldLimits.stuntDescription} символов.''';
    }
  }

  static String _parseFieldContent(CharacterRegenField field, String raw) {
    if (field == CharacterRegenField.description) {
      return CharacterFieldFragmentParser.parseDescriptionFragment(raw);
    }
    return CharacterFieldFragmentParser.parsePlainLine(raw);
  }
}
