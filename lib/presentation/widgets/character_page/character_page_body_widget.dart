import 'package:fate_app/presentation/pages/character_page/character_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainCharacterBodyWidget extends ConsumerWidget {
  const MainCharacterBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterPageViewProvider).characters;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          actions: [IconButton(onPressed: null, icon: Icon(Icons.add))],
          centerTitle: true,
          title: Text("FATE"),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final character = characters[index];
              return ListTile(
                title: Text(character.name),
                subtitle: Text(character.description),
              );
            },
            childCount: characters.length,
          ),
        ),
      ],
    );
  }
}
