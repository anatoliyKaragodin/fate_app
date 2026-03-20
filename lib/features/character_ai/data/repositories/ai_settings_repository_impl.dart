import 'package:fate_app/features/character_ai/data/ai_api_key_source.dart';
import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiSettingsRepositoryImpl implements AiSettingsRepository {
  AiSettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _keyProvider = 'ai_selected_provider';

  @override
  Future<AiProvider> getSelectedProvider() async {
    final name = _prefs.getString(_keyProvider);
    if (name == null) return AiProvider.groq;
    // Старые сборки могли сохранить удалённый вариант `openai`.
    if (name == 'openai') return AiProvider.groq;
    for (final p in AiProvider.values) {
      if (p.name == name) {
        return p;
      }
    }
    return AiProvider.groq;
  }

  @override
  Future<void> setSelectedProvider(AiProvider provider) async {
    await _prefs.setString(_keyProvider, provider.name);
  }

  @override
  Future<String?> getApiKey(AiProvider provider) async {
    final k = switch (provider) {
      AiProvider.groq => AiApiKeySource.groqApiKey(),
      AiProvider.openRouter => AiApiKeySource.openRouterApiKey(),
    };
    return k.isEmpty ? null : k;
  }
}
