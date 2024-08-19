import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/common/app_character_small_container.dart';

class CharactersListPage extends ConsumerWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(charactersListPageViewProvider).characters;

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(charactersListPageViewProvider.notifier)
            .fetchCharacters();
      },
      child: CustomScrollView(
        slivers: [
          _AppBar(
            onTapNew: () => ref
                .read(charactersListPageViewProvider.notifier)
                .createCharacter(ref),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final character = characters[index];
                return AppCharacterSmallContainer(
                  character: character,
                  onTap: () => ref
                      .read(charactersListPageViewProvider.notifier)
                      .editCharacter(ref, characters[index]),
                  onTapDelete: () => ref
                      .read(charactersListPageViewProvider.notifier)
                      .onTapDeleteCharacter(context, character),
                );
              },
              childCount: characters.length,
            ),
          ),
        ],
      ),
    ));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.onTapNew});

  final VoidCallback onTapNew;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 100.height(context),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text("FAE"),
        expandedTitleScale: 1.1,
        background: Container(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
          child: const Center(
            child: Text(
              "Убежище персонажей для",
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onTapNew,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
