import 'package:fate_app/features/character_ai/data/ai_api_key_source.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';

class AiSettingsRepositoryImpl implements AiSettingsRepository {
  @override
  Future<String?> getApiKey(AiProvider provider) async {
    final k = switch (provider) {
      AiProvider.groq => AiApiKeySource.groqApiKey(),
      AiProvider.openRouter => AiApiKeySource.openRouterApiKey(),
    };
    return k.isEmpty ? null : k;
  }
}
