import 'package:fate_app/features/characters/presentation/pages/character_edit_page/character_edit_page.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page.dart';
import 'package:fate_app/features/characters/presentation/pages/fullscreen_image_page/fullscreen_image_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/characters/presentation/pages/character_play_page/character_play_page.dart';

class RouterHelper {
  static final RouterHelper _instance = RouterHelper._internal();

  static RouterHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  // static final GlobalKey<NavigatorState> allCharactersNavigatorKey =
  //     GlobalKey<NavigatorState>();

  // static final GlobalKey<NavigatorState> characterEditNavigatorKey =
  //     GlobalKey<NavigatorState>();

  static const String allCharactersPath = '/';
  static const String characterEditPath = '/character_edit';
  static const String characterPlayPath = '/character_play';
  static const String fullscreenImagePath = '/fullscreen_image';

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
        path: characterEditPath,
        pageBuilder: (context, state) {
          return getPage(child: const CharacterEditPage(), state: state);
        },
      ),
      GoRoute(
        path: characterPlayPath,
        pageBuilder: (context, state) {
          return getPage(child: const CharacterPlayPage(), state: state);
        },
      ),
      GoRoute(
        path: fullscreenImagePath,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          
          return getPage(
              child: FullscreenImagePage(
                imagePath: extra?['imagePath'],
              ),
              state: state);
        },
      ),
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
