import 'dart:convert';

import 'package:fate_app/core/di/di_container.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDI();

  RouterHelper.instance;

  // Загружаем переменные из .env файла
  await dotenv.load(fileName: ".env");

  // Получаем конфигурацию из .env
  final firebaseConfigString = dotenv.env['FIREBASE_CONFIG']!;

  // Парсим JSON-конфигурацию
  final firebaseConfig = jsonDecode(firebaseConfigString);

  // Инициализация Firebase с использованием данных из JSON
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: firebaseConfig['apiKey'],
      appId: firebaseConfig['appId'],
      messagingSenderId: firebaseConfig['messagingSenderId'],
      projectId: firebaseConfig['projectId'],
      storageBucket: firebaseConfig['storageBucket'],
    ),
  );

  // Ошибки
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  // Async ошибки
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);

    return true;
  };

  runApp(const ProviderScope(child: App()));
}
