import 'package:fate_app/features/characters/presentation/pages/character_page/character_page.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterHelper {
  static final RouterHelper _instance = RouterHelper._internal();

  static RouterHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> allCharactersNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> characterNavigatorKey =
      GlobalKey<NavigatorState>();

  static const String allCharactersPath = '/';
  static const String characterPath = '/characters';

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  factory RouterHelper() {
    return _instance;
  }

  RouterHelper._internal() {
    final routes = [
      GoRoute(
          path: allCharactersPath,
          pageBuilder: (context, state) {
            return getPage(child: const CharactersListPage(), state: state);
          }),
      GoRoute(
          path: characterPath,
          pageBuilder: (context, state) {
            return getPage(child: const CharacterPage(), state: state);
          },
          builder: (context, state) => const CharacterPage()),
    ];

    router = GoRouter(
        navigatorKey: parentNavigatorKey,
        initialLocation: allCharactersPath,
        routes: routes);
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
