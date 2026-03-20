import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void initialize() {
    final crashlyticsReady = Firebase.apps.isNotEmpty;

    FlutterError.onError = (errorDetails) {
      if (crashlyticsReady) {
        try {
          FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
        } catch (_) {/* Crashlytics без нативной конфигурации */}
      }
      FlutterError.presentError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (crashlyticsReady) {
        try {
          FirebaseCrashlytics.instance.recordError(error, stack);
        } catch (_) {/* см. выше */}
      } else if (kDebugMode) {
        debugPrint('Async error: $error\n$stack');
      }
      return true;
    };
  }
}
