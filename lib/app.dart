import 'package:flutter/material.dart';

import 'core/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: MediaQuery.of(context).platformBrightness),
        useMaterial3: true,
      ),
      routerConfig: RouterHelper.router,
    );
  }
}
