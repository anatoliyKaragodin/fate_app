import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';

/// Конфиг под OpenAI-совместимый chat completions (Groq, OpenRouter и т.д.):
/// `POST …/chat/completions`, `Authorization: Bearer <key>`, тело: `model`, `messages`, …
class LlmProviderConfig {
  final String baseUrl;
  final String defaultModel;

  /// Доп. заголовки (например OpenRouter: [HTTP-Referer], [X-Title]).
  final Map<String, String> extraHeaders;

  const LlmProviderConfig({
    required this.baseUrl,
    required this.defaultModel,
    this.extraHeaders = const {},
  });

  static LlmProviderConfig forProvider(AiProvider provider) => switch (provider) {
        AiProvider.openRouter => openRouter,
        AiProvider.groq => groq,
      };

  static const groq = LlmProviderConfig(
    baseUrl: 'https://api.groq.com/openai/v1',
    defaultModel: 'llama-3.3-70b-versatile',
  );

  /// [OpenRouter](https://openrouter.ai/docs): бесплатные модели с суффиксом `:free`.
  ///
  /// По умолчанию — `meta-llama/llama-3.1-8b-instruct:free`: литературность и гибкость
  /// по характеру персонажа (RPG), меньше ограничений по тону.
  /// Альтернатива: `google/gemini-flash-1.5-8b:free` — больше контекста, сильный русский,
  /// иногда осторожнее к мрачному контенту. Сменить — поле [defaultModel] ниже.
  static const openRouter = LlmProviderConfig(
    baseUrl: 'https://openrouter.ai/api/v1',
    defaultModel: 'meta-llama/llama-3.1-8b-instruct:free',
    extraHeaders: {
      'HTTP-Referer': 'https://github.com/fate-app',
      'X-Title': 'Fate App',
    },
  );
}
