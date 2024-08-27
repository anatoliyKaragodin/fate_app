import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/character_edit_page/character_edit_page_view_model.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_focus_container_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_icon_button.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../widgets/common/app_character_avatar_widget.dart';

class CharacterEditPage extends ConsumerWidget {
  const CharacterEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wmProvider = ref.watch(characterEditPageViewModelProvider);

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          _AppBar(
            image: wmProvider.character.image,
            onTapBack: () => ref
                .read(characterEditPageViewModelProvider.notifier)
                .goBack(context),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appPadding.bigW(context)),
              child: Column(
                children: [
                  AppButtonWidget(
                    text: 'Загрузить аватар',
                    onPressed: () => ref
                        .read(characterEditPageViewModelProvider.notifier)
                        .loadImage(context),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: wmProvider.nameController,
                      hintText: 'Имя',
                      maxLength: 100,
                      onTapHelp: () => ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .showHelp(context, CharHelpType.name),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: wmProvider.conceptController,
                      hintText: 'Концепт',
                      maxLength: 100,
                      onTapHelp: () => ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .showHelp(context, CharHelpType.concept),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  _Skills(
                    skills: wmProvider.character.skills,
                    skillAvailableList: wmProvider.skillAvailableList,
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: wmProvider.problemController,
                      hintText: 'Проблема',
                      maxLength: 100,
                      onTapHelp: () => ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .showHelp(context, CharHelpType.problem),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  _Aspects(
                      aspectControllers: wmProvider.aspectControllers,
                      onTapHelp: () => ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .showHelp(context, CharHelpType.aspect)),
                  Gap(appPadding.bigH(context)),
                  _Stunts(
                    stuntControllers: wmProvider.stuntControllers,
                    stunts: wmProvider.character.stunts,
                    onTapHelp: () => ref
                        .read(characterEditPageViewModelProvider.notifier)
                        .showHelp(context, CharHelpType.stunt),
                    onSelectStuntType: (int index, StuntType? value) {
                      ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .saveStuntType(index, value);
                    },
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: wmProvider.descriptionController,
                      hintText: 'Описание',
                      maxLength: 500,
                      onTapHelp: () => ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .showHelp(context, CharHelpType.description),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtonWidget(
                          text: 'Экспорт pdf',
                          onPressed: () {
                            ref
                                .read(
                                    characterEditPageViewModelProvider.notifier)
                                .exportPDF(context, ref);
                          }),
                      AppButtonWidget(
                        text: 'Сохранить',
                        onPressed: () {
                          ref
                              .read(characterEditPageViewModelProvider.notifier)
                              .saveCharacter(context, ref);
                        },
                      ),
                    ],
                  ),
                  Gap(appPadding.bigH(context)),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class _Stunts extends StatelessWidget {
  const _Stunts(
      {required this.onTapHelp,
      required this.onSelectStuntType,
      required this.stunts,
      required this.stuntControllers});

  final VoidCallback onTapHelp;
  final Function(int index, StuntType?) onSelectStuntType;
  final List<StuntEntity> stunts;
  final List<TextEditingController> stuntControllers;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Трюки:',
              style: appTextStyles.text1(context),
            ),
            AppIconButton(onTap: onTapHelp),
          ],
        ),
        ...List.generate(
          3,
          (index) => Column(
            children: [
              AppDropdownMenu<StuntType>(
                width: 230.width(context),
                label: 'тип:',
                menuItems: StuntType.values,
                selectedItem: stunts[index].type,
                onItemSelected: (StuntType? value) =>
                    onSelectStuntType(index, value),
              ),
              AppTextFieldWidget(
                controller: stuntControllers[index],
                hintText: 'Трюк',
                maxLength: 100,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _Aspects extends StatelessWidget {
  const _Aspects({required this.onTapHelp, required this.aspectControllers});

  final VoidCallback onTapHelp;
  final List<TextEditingController> aspectControllers;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Аспекты:',
              style: appTextStyles.text1(context),
            ),
            AppIconButton(onTap: onTapHelp),
          ],
        ),
        ...List.generate(
          3,
          (index) => AppTextFieldWidget(
            controller: aspectControllers[index],
            hintText: 'Аспект',
            maxLength: 100,
          ),
        ),
      ]),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.image, required this.onTapBack});

  final String? image;
  final VoidCallback onTapBack;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: image != null ? 220.height(context) : null,
      flexibleSpace: image != null
          ? FlexibleSpaceBar(
              background: AppCharacterAvatarWidget(
                imagePath: image!,
                width: 200.width(context),
                height: 200.height(context),
              ),
            )
          : null,
      leading: BackButton(
        onPressed: onTapBack,
      ),
    );
  }
}

class _SkillColumn extends StatelessWidget {
  const _SkillColumn(
      {required this.skills,
      required this.width,
      required this.skillAvailableList,
      required this.onTap});

  final List<SkillEntity> skills;
  final double width;
  final List<int?> skillAvailableList;
  final Function(int index, int? value) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          skills.length,
          (index) => AppDropdownMenu<int>(
                width: width,
                label: skills[index].type.toLabel(),
                menuItems: skillAvailableList.contains(skills[index].value)
                    ? skillAvailableList
                    : [...skillAvailableList, skills[index].value],
                selectedItem: skills[index].value,
                onItemSelected: (int? value) {
                  onTap(index, value);
                },
              )),
    );
  }
}

class _Skills extends ConsumerWidget {
  const _Skills({required this.skillAvailableList, required this.skills});

  final List<SkillEntity> skills;
  final List<int?> skillAvailableList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppFocusContainerWidget(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Подходы',
              style: appTextStyles.text1(context),
            ),
            AppIconButton(
                onTap: () => ref
                    .read(characterEditPageViewModelProvider.notifier)
                    .showHelp(context, CharHelpType.skill))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SkillColumn(
              onTap: (index, value) => ref
                  .read(characterEditPageViewModelProvider.notifier)
                  .saveSkill(index, value),
              skillAvailableList: skillAvailableList,
              skills: skills.sublist(0, skills.length ~/ 2),
              width: 150.width(context),
            ),
            _SkillColumn(
              onTap: (index, value) => ref
                  .read(characterEditPageViewModelProvider.notifier)
                  .saveSkill(index + skills.length ~/ 2, value),
              skillAvailableList: skillAvailableList,
              skills: skills.sublist(skills.length ~/ 2, skills.length),
              width: 150.width(context),
            ),
          ],
        ),
      ]),
    );
  }
}
