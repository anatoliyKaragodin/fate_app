import 'package:dartz/dartz.dart' hide State;
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/error/failure_user_message.dart';
import 'package:fate_app/core/utils/theme/app_padding.dart';
import 'package:fate_app/core/utils/theme/app_text_styles.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';
import 'package:fate_app/features/characters/domain/character_field_limits.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/character_edit_page/character_edit_page_view_model.dart';
import 'package:fate_app/core/utils/app_size.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_button_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_dropdown_menu.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_focus_container_widget.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_icon_button.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_text_field_widget.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;
import 'package:gap/gap.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../widgets/common/app_character_avatar_widget.dart';
import '../../widgets/common/app_bottom_sheet.dart';

class CharacterEditPage extends ConsumerStatefulWidget {
  const CharacterEditPage({super.key});

  @override
  ConsumerState<CharacterEditPage> createState() => _CharacterEditPageState();
}

class _CharacterEditPageState extends ConsumerState<CharacterEditPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _conceptController;
  late final TextEditingController _problemController;
  late final TextEditingController _descriptionController;
  late final List<TextEditingController> _aspectControllers;
  late final List<TextEditingController> _stuntControllers;

  /// Список вызывает [initNewCharacter] до открытия маршрута; [ref.listen] при
  /// первой подписке не вызывается — без однократной гидратации поля пустые.
  bool _scheduledInitialControllerSync = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _conceptController = TextEditingController();
    _problemController = TextEditingController();
    _descriptionController = TextEditingController();
    _aspectControllers = List.generate(3, (_) => TextEditingController());
    _stuntControllers = List.generate(3, (_) => TextEditingController());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _conceptController.dispose();
    _problemController.dispose();
    _descriptionController.dispose();
    for (final c in _aspectControllers) {
      c.dispose();
    }
    for (final c in _stuntControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _syncControllers(CharacterEntity character) {
    _nameController.text = character.name;
    _conceptController.text = character.concept;
    _problemController.text = character.problem;
    _descriptionController.text = character.description;
    for (int i = 0; i < _aspectControllers.length; i++) {
      _aspectControllers[i].text =
          i < character.aspects.length ? character.aspects[i] : '';
    }
    for (int i = 0; i < _stuntControllers.length; i++) {
      _stuntControllers[i].text = i < character.stunts.length
          ? (character.stunts[i].description ?? '')
          : '';
    }
  }

  void _showBottomSheet(BuildContext context, String text) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => AppBottomSheet(text: text),
    );
  }

  Future<void> _onGenerateWithAi(BuildContext context, WidgetRef ref) async {
    // Контроллер только в State диалога — dispose после снятия маршрута.
    // Раньше dispose() в finally сразу после pop ломал TextField на кадре анимации закрытия.
    final hint = await showDialog<String?>(
      context: context,
      builder: (ctx) => const _AiCharacterHintDialog(),
    );

    if (!context.mounted) return;
    if (hint == null) return;

    if (hint.isEmpty) {
      _showBottomSheet(context, 'Введите краткое описание идеи.');
      return;
    }

    dev.log('[AI] открываем индикатор, hint length=${hint.length}');

    final cancelToken = CancelToken();
    var loadingDismissed = false;
    void dismissLoading() {
      if (loadingDismissed || !context.mounted) return;
      loadingDismissed = true;
      Navigator.of(context, rootNavigator: true).pop();
      dev.log('[AI] индикатор закрыт');
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Генерация…'),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        cancelToken.cancel();
                        dismissLoading();
                        dev.log('[AI] отмена по кнопке');
                      },
                      child: const Text('Отменить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    late Either<Failure, void> outcome;
    try {
      dev.log('[AI] вызов generateCharacterWithAi…');
      outcome = await ref
          .read(characterEditPageViewModelProvider.notifier)
          .generateCharacterWithAi(hint, cancelToken: cancelToken);
      dev.log('[AI] generateCharacterWithAi завершён (fold дальше)');
    } catch (e, st) {
      dev.log('[AI] исключение в generateCharacterWithAi',
          error: e, stackTrace: st);
      outcome = Left(UnknownFailure(message: e.toString(), cause: e));
    } finally {
      dismissLoading();
    }

    if (!context.mounted) return;

    outcome.fold(
      (f) {
        if (f is OperationCancelledFailure) {
          dev.log('[AI] генерация отменена, без сообщения об ошибке');
          return;
        }
        final userText = describeCharacterAiGenerationFailureForUser(f);
        debugPrint('[AI] Ошибка генерации (UI): $userText');
        dev.log('[AI] Ошибка генерации (UI): $userText');
        dev.log('[AI] Ошибка генерации (детали): ${describeFailureForUser(f)}');
        _showBottomSheet(context, userText);
      },
      (_) {
        debugPrint('[AI] Черновик применён успешно');
        dev.log('[AI] черновик применён успешно');
      },
    );
  }

  Future<void> _onGenerateAvatar(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final cancelToken = CancelToken();
    var loadingDismissed = false;
    void dismissLoading() {
      if (loadingDismissed || !context.mounted) return;
      loadingDismissed = true;
      Navigator.of(context, rootNavigator: true).pop();
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Генерация аватара…'),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        cancelToken.cancel();
                        dismissLoading();
                        dev.log('[Avatar] отмена по кнопке');
                      },
                      child: const Text('Отменить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    late Either<Failure, void> outcome;
    try {
      outcome = await ref
          .read(characterEditPageViewModelProvider.notifier)
          .generateAvatar(
            name: _nameController.text,
            concept: _conceptController.text,
            problem: _problemController.text,
            description: _descriptionController.text,
            cancelToken: cancelToken,
          );
    } catch (e, st) {
      dev.log('[Avatar] исключение', error: e, stackTrace: st);
      outcome = Left(UnknownFailure(message: e.toString(), cause: e));
    } finally {
      dismissLoading();
    }

    if (!context.mounted) return;

    outcome.fold(
      (f) {
        if (f is OperationCancelledFailure) {
          dev.log('[Avatar] генерация отменена, без сообщения');
          return;
        }
        final userText = describeAvatarGenerationFailureForUser(f);
        dev.log('[Avatar] детали: ${describeFailureForUser(f)}');
        _showBottomSheet(context, userText);
      },
      (_) {},
    );
  }

  Future<void> _onRegenerateField(
    BuildContext context,
    WidgetRef ref,
    CharacterRegenField field,
  ) async {
    final hint = await showDialog<String?>(
      context: context,
      builder: (ctx) => _FieldAiHintDialog(fieldLabel: field.uiLabel),
    );

    if (!context.mounted) return;
    if (hint == null) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Генерация…'),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    late Either<Failure, void> outcome;
    try {
      outcome = await ref
          .read(characterEditPageViewModelProvider.notifier)
          .regenerateCharacterFieldWithAi(field: field, hint: hint);
    } catch (e, st) {
      dev.log('[AI] исключение в regenerateField', error: e, stackTrace: st);
      outcome = Left(UnknownFailure(message: e.toString(), cause: e));
    } finally {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    if (!context.mounted) return;

    outcome.fold(
      (f) {
        final userText = describeCharacterAiGenerationFailureForUser(f);
        dev.log('[AI] Ошибка поля (детали): ${describeFailureForUser(f)}');
        _showBottomSheet(context, userText);
      },
      (_) {},
    );
  }

  Future<String?> _cropImage(String filePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    return croppedFile?.path;
  }

  @override
  Widget build(BuildContext context) {
    if (!_scheduledInitialControllerSync) {
      _scheduledInitialControllerSync = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _syncControllers(
          ref.read(characterEditPageViewModelProvider).character,
        );
      });
    }

    ref.listen(characterEditPageViewModelProvider, (prev, next) {
      final prevId = prev?.character.localeId;
      final nextId = next.character.localeId;

      if (prevId != nextId || prev?.character != next.character) {
        _syncControllers(next.character);
      }
    });

    final wmProvider = ref.watch(characterEditPageViewModelProvider);

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          _AppBar(
            image: wmProvider.character.image,
            onTapBack: () =>
                RouterHelper.router.go(RouterHelper.allCharactersPath),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appPadding.bigW(context)),
              child: Column(
                children: [
                  AppButtonWidget(
                    text: 'Сгенерировать с ИИ',
                    onPressed: () => _onGenerateWithAi(context, ref),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppButtonWidget(
                    text: 'Сгенерировать аватар',
                    onPressed: () => _onGenerateAvatar(context, ref),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppButtonWidget(
                    text: 'Загрузить аватар',
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: false,
                      );

                      if (result == null || result.files.isEmpty) return;

                      final pickedPath = result.files.first.path;
                      if (pickedPath == null) return;

                      final croppedPath = await _cropImage(pickedPath);
                      if (croppedPath == null) return;

                      await ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .importAvatar(croppedPath);
                    },
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: _nameController,
                      hintText: 'Имя',
                      maxLength: CharacterFieldLimits.name,
                      onTapHelp: () => _showBottomSheet(
                        context,
                        ref
                            .read(characterEditPageViewModelProvider.notifier)
                            .helpText(CharHelpType.name),
                      ),
                      onTapRegenerateAi: () => _onRegenerateField(
                        context,
                        ref,
                        CharacterRegenField.name,
                      ),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: _conceptController,
                      hintText: 'Концепт',
                      maxLength: CharacterFieldLimits.concept,
                      onTapHelp: () => _showBottomSheet(
                        context,
                        ref
                            .read(characterEditPageViewModelProvider.notifier)
                            .helpText(CharHelpType.concept),
                      ),
                      onTapRegenerateAi: () => _onRegenerateField(
                        context,
                        ref,
                        CharacterRegenField.concept,
                      ),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  _Skills(
                    skills: wmProvider.character.skills,
                    skillAvailableList: wmProvider.skillAvailableList,
                    onTapHelp: () => _showBottomSheet(
                      context,
                      ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .helpText(CharHelpType.skill),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: _problemController,
                      hintText: 'Проблема',
                      maxLength: CharacterFieldLimits.problem,
                      onTapHelp: () => _showBottomSheet(
                        context,
                        ref
                            .read(characterEditPageViewModelProvider.notifier)
                            .helpText(CharHelpType.problem),
                      ),
                      onTapRegenerateAi: () => _onRegenerateField(
                        context,
                        ref,
                        CharacterRegenField.problem,
                      ),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  _Aspects(
                    aspectControllers: _aspectControllers,
                    onTapHelp: () => _showBottomSheet(
                      context,
                      ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .helpText(CharHelpType.aspect),
                    ),
                    onRegenerateField: (field) =>
                        _onRegenerateField(context, ref, field),
                  ),
                  Gap(appPadding.bigH(context)),
                  _Stunts(
                    stuntControllers: _stuntControllers,
                    stunts: wmProvider.character.stunts,
                    onTapHelp: () => _showBottomSheet(
                      context,
                      ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .helpText(CharHelpType.stunt),
                    ),
                    onSelectStuntType: (int index, StuntType? value) {
                      ref
                          .read(characterEditPageViewModelProvider.notifier)
                          .saveStuntType(index, value);
                    },
                    onRegenerateField: (field) =>
                        _onRegenerateField(context, ref, field),
                  ),
                  Gap(appPadding.bigH(context)),
                  AppFocusContainerWidget(
                    child: AppTextFieldWidget(
                      controller: _descriptionController,
                      hintText: 'Описание',
                      maxLength: CharacterFieldLimits.description,
                      onTapHelp: () => _showBottomSheet(
                        context,
                        ref
                            .read(characterEditPageViewModelProvider.notifier)
                            .helpText(CharHelpType.description),
                      ),
                      onTapRegenerateAi: () => _onRegenerateField(
                        context,
                        ref,
                        CharacterRegenField.description,
                      ),
                    ),
                  ),
                  Gap(appPadding.bigH(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtonWidget(
                          text: 'Экспорт pdf',
                          onPressed: () async {
                            final notifier = ref.read(
                                characterEditPageViewModelProvider.notifier);
                            final character = wmProvider.character;

                            if (_nameController.text.isEmpty) {
                              _showBottomSheet(
                                  context, 'Напишите имя персонажа');
                              return;
                            }
                            if (_conceptController.text.isEmpty) {
                              _showBottomSheet(context, 'Напишите концепт');
                              return;
                            }
                            if (character.skills.any((s) => s.value == null)) {
                              _showBottomSheet(context, 'Выберите скиллы');
                              return;
                            }

                            final ok = await notifier.saveCharacter(
                              ref,
                              name: _nameController.text,
                              concept: _conceptController.text,
                              problem: _problemController.text,
                              description: _descriptionController.text,
                              aspects: _aspectControllers
                                  .map((c) => c.text)
                                  .toList(),
                              stunts:
                                  _stuntControllers.map((c) => c.text).toList(),
                            );

                            if (!ok) return;

                            final pdf = await notifier.createPdf();
                            await notifier.exportPDF(pdf);
                            RouterHelper.router
                                .go(RouterHelper.allCharactersPath);
                          }),
                      AppButtonWidget(
                        text: 'Сохранить',
                        onPressed: () async {
                          final notifier = ref.read(
                              characterEditPageViewModelProvider.notifier);
                          final character = wmProvider.character;

                          if (_nameController.text.isEmpty) {
                            _showBottomSheet(context, 'Напишите имя персонажа');
                            return;
                          }
                          if (_conceptController.text.isEmpty) {
                            _showBottomSheet(context, 'Напишите концепт');
                            return;
                          }
                          if (character.skills.any((s) => s.value == null)) {
                            _showBottomSheet(context, 'Выберите скиллы');
                            return;
                          }

                          final ok = await notifier.saveCharacter(
                            ref,
                            name: _nameController.text,
                            concept: _conceptController.text,
                            problem: _problemController.text,
                            description: _descriptionController.text,
                            aspects:
                                _aspectControllers.map((c) => c.text).toList(),
                            stunts:
                                _stuntControllers.map((c) => c.text).toList(),
                          );
                          if (!ok) return;

                          RouterHelper.router
                              .go(RouterHelper.allCharactersPath);
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
  const _Stunts({
    required this.onTapHelp,
    required this.onSelectStuntType,
    required this.stunts,
    required this.stuntControllers,
    required this.onRegenerateField,
  });

  static const _stuntFields = [
    CharacterRegenField.stunt0,
    CharacterRegenField.stunt1,
    CharacterRegenField.stunt2,
  ];

  final VoidCallback onTapHelp;
  final Function(int index, StuntType?) onSelectStuntType;
  final List<StuntEntity> stunts;
  final List<TextEditingController> stuntControllers;
  final void Function(CharacterRegenField field) onRegenerateField;

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(appPadding.smallH(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Трюк ${index + 1}',
                      style: appTextStyles.text2(context),
                    ),
                  ),
                  Tooltip(
                    message: 'Перегенерировать этот трюк с ИИ',
                    child: AppIconButton(
                      onTap: () => onRegenerateField(_stuntFields[index]),
                      icon: Icons.auto_awesome_outlined,
                    ),
                  ),
                ],
              ),
              Gap(appPadding.smallH(context)),
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
                hintText: 'Описание трюка',
                maxLength: CharacterFieldLimits.stuntDescription,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _Aspects extends StatelessWidget {
  const _Aspects({
    required this.onTapHelp,
    required this.aspectControllers,
    required this.onRegenerateField,
  });

  static const _aspectFields = [
    CharacterRegenField.aspect0,
    CharacterRegenField.aspect1,
    CharacterRegenField.aspect2,
  ];

  final VoidCallback onTapHelp;
  final List<TextEditingController> aspectControllers;
  final void Function(CharacterRegenField field) onRegenerateField;

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
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(appPadding.smallH(context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Аспект ${index + 1}',
                      style: appTextStyles.text2(context),
                    ),
                  ),
                  Tooltip(
                    message: 'Перегенерировать этот аспект с ИИ',
                    child: AppIconButton(
                      onTap: () => onRegenerateField(_aspectFields[index]),
                      icon: Icons.auto_awesome_outlined,
                    ),
                  ),
                ],
              ),
              Gap(appPadding.smallH(context)),
              AppTextFieldWidget(
                controller: aspectControllers[index],
                hintText: 'Аспект',
                maxLength: CharacterFieldLimits.aspect,
              ),
            ],
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
      leading: AppIconButton(
        icon: Icons.arrow_back_ios_new,
        onTap: onTapBack,
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
                height: 30.height(context),
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
  const _Skills(
      {required this.skillAvailableList,
      required this.skills,
      required this.onTapHelp});

  final List<SkillEntity> skills;
  final List<int?> skillAvailableList;
  final VoidCallback onTapHelp;

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
            AppIconButton(onTap: onTapHelp)
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

/// Уточнение для перегенерации одного поля (пустой текст допустим).
class _FieldAiHintDialog extends StatefulWidget {
  const _FieldAiHintDialog({required this.fieldLabel});

  final String fieldLabel;

  @override
  State<_FieldAiHintDialog> createState() => _FieldAiHintDialogState();
}

class _FieldAiHintDialogState extends State<_FieldAiHintDialog> {
  late final TextEditingController _hintController;

  @override
  void initState() {
    super.initState();
    _hintController = TextEditingController();
  }

  @override
  void dispose() {
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('ИИ: ${widget.fieldLabel}'),
      content: TextField(
        controller: _hintController,
        maxLines: 4,
        decoration: const InputDecoration(
          hintText:
              'Пожелания (необязательно): тон, акцент, что оставить или изменить',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _hintController.text.trim()),
          child: const Text('Перегенерировать'),
        ),
      ],
    );
  }
}

/// Диалог ввода идеи для ИИ: [TextEditingController] живёт до [dispose] State,
/// а не до `finally` после [Navigator.pop] (иначе «used after being disposed»).
class _AiCharacterHintDialog extends StatefulWidget {
  const _AiCharacterHintDialog();

  @override
  State<_AiCharacterHintDialog> createState() => _AiCharacterHintDialogState();
}

class _AiCharacterHintDialogState extends State<_AiCharacterHintDialog> {
  late final TextEditingController _hintController;

  @override
  void initState() {
    super.initState();
    _hintController = TextEditingController();
  }

  @override
  void dispose() {
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Идея персонажа'),
      content: TextField(
        controller: _hintController,
        maxLines: 4,
        decoration: const InputDecoration(
          hintText:
              'Например: циничный пилот на окраине Марса, боится ответственности',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _hintController.text.trim()),
          child: const Text('Сгенерировать'),
        ),
      ],
    );
  }
}
