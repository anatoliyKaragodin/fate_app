import 'package:fate_app/core/database/database_manager.dart';
import 'package:fate_app/core/di/di_container.dart';
import 'package:fate_app/core/error/error_handler.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDI();

  RouterHelper.instance;

  await DatabaseManager.initFirebase();

  ErrorHandler.initialize();

  runApp(const ProviderScope(child: App()));
}
