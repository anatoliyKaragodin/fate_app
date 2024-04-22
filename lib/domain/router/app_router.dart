import 'package:fate_app/presentation/pages/character_page/character_page.dart';
import 'package:fate_app/presentation/pages/characters_list_page/characters_list_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(routes: [
        GoRoute(path: '/', builder: (context, state) => const CharactersListPage()),
        GoRoute(path: '/characters', builder: (context, state) => const CharactersListPage()),
        GoRoute(path: '/characters/character', builder: (context, state) => const CharacterPage()),
      ]);
}

