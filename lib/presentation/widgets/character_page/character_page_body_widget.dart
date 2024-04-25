import 'package:fate_app/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/presentation/widgets/common/app_character_small_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainCharacterBodyWidget extends ConsumerWidget {
  const MainCharacterBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(CharactersListPageViewProvider).characters;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            IconButton(
                onPressed: () => context.go('/characters/character'),
                icon: Icon(Icons.add))
          ],
          centerTitle: true,
          title: Text("FATE"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final character = characters[index];
              return AppCharacterSmallContainer(character: character);
            },
            childCount: characters.length,
          ),
        ),
      ],
    );
  }
}
