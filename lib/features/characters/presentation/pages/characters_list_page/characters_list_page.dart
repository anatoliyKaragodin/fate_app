import 'package:fate_app/core/rustore_updater/rustore_updater.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/theme/app_text_styles.dart';
import '../../widgets/common/app_character_small_container.dart';
import '../../widgets/common/app_icon_button.dart';

class CharactersListPage extends ConsumerWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmProvider = ref.watch(charactersListPageViewProvider);
    final characters = vmProvider.characters;

    // final updaterProvider = ref.watch(updaterRustoreProvider);

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
            onTapSort: (value) =>
                ref.read(charactersListPageViewProvider.notifier).sortBy(value),
            onTapNew: () => ref
                .read(charactersListPageViewProvider.notifier)
                .createCharacter(ref),
            selectedSort: vmProvider.sortType.toLabel(),
          ),
          // if (updaterProvider)
          //   SliverToBoxAdapter(
          //     child: Center(
          //       child: AppButtonWidget(
          //           text: 'Обновить приложение',
          //           onPressed: () =>
          //               ref.read(updaterRustoreProvider.notifier).update()),
          //     ),
          //   ),
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
  const _AppBar(
      {required this.onTapNew,
      required this.onTapSort,
      required this.selectedSort});

  final VoidCallback onTapNew;

  final Function(String? value) onTapSort;

  final String? selectedSort;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      expandedHeight: 95.height(context),
      collapsedHeight: 70.height(context),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("FAE", style: appTextStyles.title1(context)),
            Gap(appPadding.smallH(context)),
            AppDropdownMenu<String>(
                height: 20.height(context),
                width: 220.width(context),
                onItemSelected: (value) => onTapSort(value),
                selectedItem: selectedSort,
                label: 'сортировка по:',
                menuItems: [
                  SortType.no.toLabel(),
                  SortType.name.toLabel(),
                  SortType.createdAt.toLabel(),
                  SortType.updatedAt.toLabel()
                ]),
          ],
        ),
        expandedTitleScale: 1.1,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 35.height(context)),
              child: Text(
                "Убежище персонажей для",
                style: appTextStyles.text1(context),
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppIconButton(
          onTap: onTapNew,
          icon: Icons.add,
        ),
      ],
    );
  }
}
