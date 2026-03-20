import 'package:fate_app/core/rustore_updater/rustore_updater.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/character_edit_page/character_edit_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/pages/character_play_page/character_play_page_vm.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_warning_dialog_widget.dart';
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

    final updaterProvider = ref.watch(updaterRustoreProvider);

    void goToNewCharacter() {
      final character = CharacterEntity.empty();
      ref
          .read(characterEditPageViewModelProvider.notifier)
          .initNewCharacter(character);
      RouterHelper.router.go(RouterHelper.characterEditPath);
    }

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(charactersListPageViewProvider.notifier)
            .fetchCharacters();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _AppBar(
            onTapSort: (value) =>
                ref.read(charactersListPageViewProvider.notifier).sortBy(value),
            onTapNew: goToNewCharacter,
            onTapSettings: () =>
                RouterHelper.router.go(RouterHelper.aiSettingsPath),
            selectedSort: vmProvider.sortType.toLabel(),
          ),
          if (updaterProvider)
            SliverToBoxAdapter(
              child: Center(
                child: AppButtonWidget(
                    text: 'Обновить приложение',
                    onPressed: () =>
                        ref.read(updaterRustoreProvider.notifier).update()),
              ),
            ),
          if (characters.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(appPadding.bigW(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.groups_outlined,
                      size: 64.width(context),
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    Gap(appPadding.bigH(context)),
                    Text(
                      'Пока нет персонажей',
                      textAlign: TextAlign.center,
                      style: appTextStyles.title1(context),
                    ),
                    Gap(appPadding.smallH(context)),
                    Text(
                      'Создайте первого, чтобы начать игру.',
                      textAlign: TextAlign.center,
                      style: appTextStyles.text2(context),
                    ),
                    Gap(appPadding.bigH(context)),
                    AppButtonWidget(text: 'Создать персонажа', onPressed: goToNewCharacter),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final character = characters[index];

                  return Padding(
                    padding: EdgeInsets.all(appPadding.bigW(context)),
                    child: AppCharacterSmallContainer(
                      character: character,
                      onTap: () {
                        ref
                            .read(characterPlayPageVMProvider.notifier)
                            .initCharacter(character);
                        RouterHelper.router.go(RouterHelper.characterPlayPath);
                      },
                      onTapDelete: () {
                        showDialog<void>(
                          context: context,
                          builder: (dialogContext) {
                            return AppWarningDialogWidget(
                              button1Text: 'Да',
                              button2Text: 'Нет',
                              onTapButton1: () {
                                ref
                                    .read(charactersListPageViewProvider.notifier)
                                    .deleteCharacter(character);
                                Navigator.of(dialogContext).pop();
                              },
                              onTapButton2: () =>
                                  Navigator.of(dialogContext).pop(),
                              text:
                                  'Вы уверены, что хотите предать ${character.name.toUpperCase()} забвению?',
                              title: 'Внимание!',
                            );
                          },
                        );
                      },
                      onTapEdit: () {
                        ref
                            .read(characterEditPageViewModelProvider.notifier)
                            .initNewCharacter(character);
                        RouterHelper.router.go(RouterHelper.characterEditPath);
                      },
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
      required this.onTapSettings,
      required this.selectedSort});

  final VoidCallback onTapNew;

  final VoidCallback onTapSettings;

  final Function(String? value) onTapSort;

  final String? selectedSort;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      expandedHeight: 118.height(context),
      collapsedHeight: 74.height(context),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
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
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 8.height(context),
              ),
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
          onTap: onTapSettings,
          icon: Icons.settings,
        ),
        AppIconButton(
          onTap: onTapNew,
          icon: Icons.add,
        ),
      ],
    );
  }
}
