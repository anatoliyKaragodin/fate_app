import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/theme/app_text_styles.dart';
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

                return Padding(
                  padding: EdgeInsets.all(appPadding.bigW(context)),
                  child: AppCharacterSmallContainer(
                    character: character,
                    onTap: () => ref
                        .read(charactersListPageViewProvider.notifier)
                        .goCharacterEditPage(ref, character),
                    onTapDelete: () => ref
                        .read(charactersListPageViewProvider.notifier)
                        .onTapDeleteCharacter(context, character),
                    onTapEdit: () => ref
                        .read(charactersListPageViewProvider.notifier)
                        .editCharacter(ref, character),
                  ),
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
        title: Text("FAE", style: appTextStyles.title1(context)),
        expandedTitleScale: 1.1,
        background: SizedBox(
          child: Center(
            child: Text(
              "Убежище персонажей для",
              style: appTextStyles.title2(context),
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
