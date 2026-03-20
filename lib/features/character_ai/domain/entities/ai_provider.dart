/// Провайдер LLM (OpenAI-совместимый chat completions).
enum AiProvider {
  groq,
  openRouter,
}

extension AiProviderX on AiProvider {
  String get displayLabel => switch (this) {
        AiProvider.groq => 'Groq',
        AiProvider.openRouter => 'OpenRouter',
      };
}
