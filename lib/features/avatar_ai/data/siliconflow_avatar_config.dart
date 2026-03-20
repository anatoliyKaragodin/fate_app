import 'package:flutter_dotenv/flutter_dotenv.dart';

/// [SiliconFlow Image API](https://docs.siliconflow.com/en/api-reference/images/images-generations).
/// Бесплатный вариант: **FLUX.1-schnell** (`black-forest-labs/FLUX.1-schnell`).
class SiliconFlowAvatarConfig {
  SiliconFlowAvatarConfig._();

  static const baseUrl = 'https://api.siliconflow.com/v1';

  static const defaultModel = 'black-forest-labs/FLUX.1-schnell';

  /// Для FLUX.1-schnell обязателен [image_size]; квадрат под аватар.
  static const imageSize = '1024x1024';

  static String get model {
    const fromDefine =
        String.fromEnvironment('SILICONFLOW_AVATAR_MODEL', defaultValue: '');
    if (fromDefine.isNotEmpty) return fromDefine;
    final e = dotenv.env['SILICONFLOW_AVATAR_MODEL']?.trim() ?? '';
    if (e.isNotEmpty) return e;
    return defaultModel;
  }
}
