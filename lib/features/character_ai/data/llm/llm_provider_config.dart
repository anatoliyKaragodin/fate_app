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

  /// [OpenRouter](https://openrouter.ai/docs): бесплатный вывод через `openrouter/free`
  /// — роутер подбирает доступную `:free` модель (у конкретных id вроде
  /// `meta-llama/…:free` периодически бывает 404 «No endpoints found»).
  ///
  /// Явная модель при необходимости: id с суффиксом `:free` из [каталога](https://openrouter.ai/models).
  static const openRouter = LlmProviderConfig(
    baseUrl: 'https://openrouter.ai/api/v1',
    defaultModel: 'openrouter/free',
    extraHeaders: {
      'HTTP-Referer': 'https://github.com/fate-app',
      'X-Title': 'Fate App',
    },
  );
}
