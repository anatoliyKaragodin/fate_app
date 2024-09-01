import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/character_play_page/character_play_page_vm.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_character_avatar_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_focus_container_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_icon_button.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CharacterPlayPage extends ConsumerWidget {
  const CharacterPlayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = characterPlayPageVMProvider;
    final vmProvider = ref.watch(vm);
    final character = vmProvider.character;
    final textStyle = vmProvider.isCompact
        ? appTextStyles.text3(context)
        : appTextStyles.text1(context);

    final paddingH = appPadding.mediumH(context);

    final aspects =
        character.aspects.where((aspect) => aspect.isNotEmpty).toList();

    final stunts = character.stunts
        .where((stunt) => stunt.description?.isNotEmpty ?? false)
        .toList();

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
            child: CustomScrollView(
          slivers: [
            _AppBar(
              isLockedScreen: vmProvider.isScreenLocked,
              onTapLockScreen: () => ref.read(vm.notifier).toggleScreenLock(),
              onSelectFateTokens: (value) {
                ref.read(vm.notifier).updateFateTokens(value);
              },
              fateTokens: character.fateTokens ?? 0,
              isCompact: vmProvider.isCompact,
              onTapBack: () => ref.read(vm.notifier).goBack(ref),
              onTapCompact: ref.read(vm.notifier).switchCompactMode,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    left: appPadding.bigW(context),
                    right: appPadding.bigW(context),
                    bottom: appPadding.bigH(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageNameConceptWidget(
                      onShowFullAvatar: () => RouterHelper.router.push(
                          RouterHelper.fullscreenImagePath,
                          extra: {'imagePath': character.image!}),
                      character: character,
                      textStyle: textStyle,
                      isCompact: vmProvider.isCompact,
                    ),
                    Gap(paddingH),
                    _Skills(
                      paddingH: paddingH,
                      skills: character.skills,
                      textStyle: textStyle,
                      onTap: (index) => ref.read(vm.notifier).onTapSkill(index),
                    ),
                    Gap(paddingH),
                    if (character.problem.isNotEmpty)
                      AppFocusContainerWidget(
                        width: double.infinity,
                        child: _LabelAndText(
                          textStyle: textStyle,
                          label: 'Проблема',
                          text: character.problem,
                        ),
                      ),
                    if (character.problem.isNotEmpty) Gap(paddingH),
                    if (aspects.isNotEmpty)
                      _Aspects(
                          aspects: aspects,
                          paddingH: paddingH,
                          textStyle: textStyle),
                    if (aspects.isNotEmpty) Gap(paddingH),
                    if (stunts.isNotEmpty)
                      _Stunts(
                          stunts: stunts,
                          paddingH: paddingH,
                          textStyle: textStyle),
                    if (stunts.isNotEmpty) Gap(paddingH),
                    _Stress(
                        isCompact: vmProvider.isCompact,
                        onSelectStress: (value) =>
                            ref.read(vm.notifier).updateStress(value),
                        stress: character.stress,
                        textStyle: textStyle),
                    Gap(paddingH),
                    _Consequences(
                        padding: paddingH,
                        onEdititng: (index, value) => ref
                            .read(vm.notifier)
                            .updateConsequence(index, value),
                        textStyle: textStyle,
                        consequencesContollers:
                            vmProvider.consequencesControllers),
                    Gap(paddingH),
                    AppFocusContainerWidget(
                      child: _LabelAndText(
                        textStyle: textStyle,
                        label: 'Описание',
                        text: character.description,
                      ),
                    ),
                    if (character.description.isNotEmpty) Gap(paddingH),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar(
      {required this.isCompact,
      required this.onTapBack,
      required this.onTapCompact,
      required this.fateTokens,
      required this.onSelectFateTokens,
      required this.isLockedScreen,
      required this.onTapLockScreen});

  final VoidCallback onTapBack;
  final VoidCallback onTapCompact;
  final Function(int value) onSelectFateTokens;
  final bool isCompact;
  final int fateTokens;
  final VoidCallback onTapLockScreen;
  final bool isLockedScreen;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(
        onPressed: onTapBack,
      ),
      actions: [
        AppIconButton(
          onTap: onTapLockScreen,
          icon: isLockedScreen ? Icons.lock : Icons.lock_open,
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.width(context)),
          child: AppIconButton(
              icon: isCompact ? Icons.add_circle : Icons.remove_circle,
              onTap: onTapCompact),
        )
      ],
      title: SizedBox(
        child: Row(
          children: [
            AppDropdownMenu<int>(
                width: 160.width(context),
                label: 'Жетоны судьбы',
                menuItems: const [0, 1, 2, 3],
                selectedItem: fateTokens,
                onItemSelected: (value) {
                  onSelectFateTokens(value ?? 0);
                })
          ],
        ),
      ),
    );
  }
}

class _ImageNameConceptWidget extends StatelessWidget {
  const _ImageNameConceptWidget(
      {required this.character,
      required this.textStyle,
      required this.isCompact,
      required this.onShowFullAvatar});

  final CharacterEntity character;
  final TextStyle textStyle;
  final bool isCompact;
  final VoidCallback onShowFullAvatar;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (character.image != null && !isCompact)
            InkWell(
              onTap: () => onShowFullAvatar(),
              child: Hero(
                tag: character.image!,
                child: AppCharacterAvatarWidget(
                  imagePath: character.image!,
                  height: 100.height(context),
                  width: 100.width(context),
                ),
              ),
            ),
          if (character.image != null && !isCompact)
            Gap(appPadding.mediumW(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LabelAndText(
                  text: character.name,
                  label: 'Имя',
                  textStyle: textStyle,
                ),
                Gap(appPadding.smallH(context)),
                _LabelAndText(
                  text: character.concept,
                  label: 'Концепт',
                  textStyle: textStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _LabelAndText extends StatelessWidget {
  const _LabelAndText({this.text, this.label, required this.textStyle});

  final String? label;
  final String? text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final labelStyle = textStyle.copyWith(fontWeight: FontWeight.bold);

    return RichText(
      text: TextSpan(
        children: [
          if (label != null) TextSpan(text: '$label: ', style: labelStyle),
          if (text != null) TextSpan(text: text, style: textStyle),
        ],
      ),
    );
  }
}

class _Skills extends StatelessWidget {
  const _Skills(
      {required this.skills,
      required this.textStyle,
      required this.onTap,
      required this.paddingH});

  final List<SkillEntity> skills;
  final TextStyle textStyle;
  final Function(int index) onTap;
  final double paddingH;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SkillsRow(
            skills: skills.sublist(0, skills.length ~/ 2),
            textStyle: textStyle,
            onTap: (index) => onTap(index)),
        Gap(paddingH),
        _SkillsRow(
            skills: skills.sublist(skills.length ~/ 2, skills.length),
            textStyle: textStyle,
            onTap: (index) => onTap(index + skills.length ~/ 2))
      ],
    );
  }
}

class _SkillsRow extends StatelessWidget {
  const _SkillsRow(
      {required this.skills, required this.textStyle, required this.onTap});

  final TextStyle textStyle;
  final List<SkillEntity> skills;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(skills.length, (index) {
          final skill = skills[index];

          return AppButtonWidget(
              textStyle: textStyle,
              text: '${skill.type.toLabelMin()}: ${skill.value}',
              onPressed: () => onTap(index));
        }));
  }
}

class _Aspects extends StatelessWidget {
  const _Aspects(
      {required this.aspects, required this.paddingH, required this.textStyle});

  final List<String> aspects;
  final TextStyle textStyle;
  final double paddingH;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
                aspects.length,
                (index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: index != aspects.length - 1 ? paddingH : 0),
                      child: _LabelAndText(
                        textStyle: textStyle,
                        text: aspects[index],
                        label: 'Аспект',
                      ),
                    ))
          ],
        ));
  }
}

class _Stunts extends StatelessWidget {
  const _Stunts(
      {required this.stunts, required this.paddingH, required this.textStyle});

  final List<StuntEntity> stunts;
  final TextStyle textStyle;
  final double paddingH;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
                stunts.length,
                (index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: index != stunts.length - 1 ? paddingH : 0),
                      child: _LabelAndText(
                        textStyle: textStyle,
                        text:
                            '(${stunts[index].type.toLabel()}) ${stunts[index].description}',
                        label: 'Трюк',
                      ),
                    ))
          ],
        ));
  }
}

class _Stress extends StatelessWidget {
  const _Stress(
      {required this.onSelectStress,
      required this.stress,
      required this.textStyle,
      required this.isCompact});

  final TextStyle textStyle;
  final int? stress;
  final bool isCompact;
  final Function(int value) onSelectStress;

  @override
  Widget build(BuildContext context) {
    final double diameter = isCompact ? 20 : 25;
    return AppFocusContainerWidget(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LabelAndText(
          textStyle: textStyle,
          label: 'Стресс',
        ),
        ...List.generate(
            3,
            (index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: appPadding.mediumW(context)),
                  child: InkWell(
                    onTap: () => onSelectStress(index + 1),
                    child: Container(
                      width: diameter.width(context),
                      height: diameter.height(context),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).dividerColor),
                          shape: BoxShape.circle),
                      child: stress != null && index < stress!
                          ? Center(
                              child: Icon(
                                size: diameter / 1.5.width(context),
                                Icons.close,
                                color: Theme.of(context).dividerColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                ))
      ],
    ));
  }
}

class _Consequences extends StatefulWidget {
  const _Consequences(
      {required this.consequencesContollers,
      required this.textStyle,
      required this.onEdititng,
      required this.padding});

  final List<TextEditingController> consequencesContollers;

  final TextStyle textStyle;

  final double padding;

  final Function(int index, String value) onEdititng;

  @override
  State<_Consequences> createState() => _ConsequencesState();
}

class _ConsequencesState extends State<_Consequences> {
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return AppFocusContainerWidget(
        child: !showList
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LabelAndText(
                    textStyle: widget.textStyle,
                    label: 'Последствия',
                  ),
                  AppIconButton(
                      icon: Icons.add_circle,
                      onTap: () {
                        setState(() {
                          showList = !showList;
                        });
                      })
                ],
              )
            : Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LabelAndText(
                      textStyle: widget.textStyle,
                      label: 'Последствия',
                    ),
                    AppIconButton(
                        icon: showList ? Icons.remove_circle : Icons.add_circle,
                        onTap: () {
                          setState(() {
                            showList = !showList;
                          });
                        })
                  ],
                ),
                Gap(widget.padding),
                ...List.generate(
                    widget.consequencesContollers.length,
                    (index) => Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  index < widget.consequencesContollers.length
                                      ? appPadding.mediumH(context)
                                      : 0),
                          child: AppTextFieldWidget(
                              onEditing: (value) =>
                                  widget.onEdititng(index, value),
                              textStyle: widget.textStyle,
                              controller: widget.consequencesContollers[index],
                              hintText: 'Последствие'),
                        )),
              ]));
  }
}
