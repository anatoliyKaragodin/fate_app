import 'package:flutter/material.dart';

import 'core/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 0, 14, 69),
      brightness: brightness,
    );
    const corner = 12.0;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Сверху отступы задаёт AppBar / SliverAppBar (primary). Иначе двойной inset
        // с глобальным SafeArea сжимает FlexibleSpaceBar — подпись залезает на заголовок.
        return SafeArea(
          top: false,
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: ThemeData(
        fontFamily: 'NotoSans',
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        cardTheme: CardThemeData(
          color: colorScheme.surfaceContainerHighest,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(corner),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(corner),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(corner),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(corner),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(corner),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
      ),
      routerConfig: RouterHelper.router,
    );
  }
}
