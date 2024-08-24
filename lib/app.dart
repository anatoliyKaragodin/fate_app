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
            seedColor: const Color.fromARGB(255, 0, 14, 69),
            brightness: MediaQuery.of(context).platformBrightness),
        useMaterial3: true,
      ),
      routerConfig: RouterHelper.router,
    );
  }
}
