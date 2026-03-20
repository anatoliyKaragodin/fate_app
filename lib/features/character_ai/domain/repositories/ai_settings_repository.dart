import 'package:fate_app/features/character_ai/domain/entities/ai_provider.dart';

abstract class AiSettingsRepository {
  /// Непустой ключ из dart-define / .env, иначе null.
  Future<String?> getApiKey(AiProvider provider);
}
