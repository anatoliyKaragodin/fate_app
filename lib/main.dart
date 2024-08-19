import 'package:fate_app/core/di/di_container.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  RouterHelper.instance;

  setupDI();

  runApp(const ProviderScope(child: App()));
}


