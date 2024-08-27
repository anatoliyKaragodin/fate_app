import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/features/characters/presentation/utils/character_help_text.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_file.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_pdf_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/di/di_container.dart';
import '../../../../file_managment/domain/usecases/save_pdf.dart';
import '../../widgets/common/app_bottom_sheet.dart';

final characterEditPageViewModelProvider =
    StateNotifierProvider<CharacterEditPageViewModel, CharacterEditPageState>(
        (ref) => CharacterEditPageViewModel(
            getIt.get<SaveNewCharacter>(),
            getIt.get<UpdateCharacter>(),
            getIt.get<SavePdf>(),
            getIt.get<SaveFile>()));

class CharacterEditPageViewModel extends StateNotifier<CharacterEditPageState> {
  final SaveNewCharacter _saveNewCharacterUC;
  final UpdateCharacter _updateCharacterUC;
  final SavePdf _savePdfUC;
  final SaveFile _saveFileUC;

  CharacterEditPageViewModel(this._saveNewCharacterUC, this._updateCharacterUC,
      this._savePdfUC, this._saveFileUC)
      : super(CharacterEditPageState(
            character: CharacterEntity.empty(),
            skillAvailableList: _defaultAvailableSkillList,
            aspectControllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ],
            conceptController: TextEditingController(),
            descriptionController: TextEditingController(),
            nameController: TextEditingController(),
            problemController: TextEditingController(),
            stuntControllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController(),
            ]));

  static const List<int?> _defaultAvailableSkillList = [null, 0, 1, 1, 2, 2, 3];

  void saveCharacter(BuildContext context, WidgetRef ref) {
    _saveAspects();
    _saveName();
    _saveConcept();
    _saveProblem();
    _saveStuntsDescriptions();
    _saveDescription();

    final character = state.character;

    if (!_checkCharacterComplete(context, character)) {
      return;
    }

    if (character.localeId != null) {
      _updateCharacterUC(character);
      dev.log('Character updated: $character');
    } else {
      _saveNewCharacterUC(character);
      dev.log('Character saved: $character');
    }

    ref.read(charactersListPageViewProvider.notifier).fetchCharacters();

    goBack(context);
  }

  Future<void> exportPDF(BuildContext context, WidgetRef ref) async {
    saveCharacter(context, ref);

    final pdf = await _createPDF(state.character);

    _savePdfUC(PdfParams(pdf: pdf, name: state.character.name));

    ref.read(charactersListPageViewProvider.notifier).fetchCharacters();

    goBack(context);
  }

  void goBack(BuildContext context) {
    // ref.read(charactersListPageViewProvider.notifier).fetchCharacters();

    RouterHelper.router.go(RouterHelper.allCharactersPath);
  }

  void saveStuntType(int stuntIndex, StuntType? value) {
    if (value == null) return;

    List<StuntEntity> stunts = [...state.character.stunts];

    stunts[stuntIndex] = stunts[stuntIndex].copyWith(type: value);

    state = state.copyWith(character: state.character.copyWith(stunts: stunts));
  }

  void saveSkill(int skillIndex, int? value) {
    List<SkillEntity> skills = List.from(state.character.skills);

    skills[skillIndex] = skills[skillIndex].copyWith(value: value);

    dev.log('save skills: $skills');

    final character = state.character.copyWith(skills: skills);

    state = state.copyWith(character: character);

    _updateAvailableSkillList();
  }

  void initNewCharacter(CharacterEntity character) {
    _updateControllersText(character);

    state = state.copyWith(character: character);
    _updateAvailableSkillList();
  }

  void loadImage(BuildContext context) async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      dev.log('Выбранный файл: ${file.path}');
      _saveImage(file);
    } else {
      dev.log('Файл не был выбран');
    }
  }

  void showHelp(BuildContext context, CharHelpType helpType) {
    switch (helpType) {
      case CharHelpType.name:
        _showBottomSheet(context, CharacterHelpText.name);
        break;
      case CharHelpType.concept:
        _showBottomSheet(context, CharacterHelpText.concept);
        break;
      case CharHelpType.description:
        _showBottomSheet(context, CharacterHelpText.description);
        break;
      case CharHelpType.skill:
        _showBottomSheet(context, CharacterHelpText.skill);
        break;
      case CharHelpType.aspect:
        _showBottomSheet(context, CharacterHelpText.aspect);
        break;
      case CharHelpType.stunt:
        _showBottomSheet(context, CharacterHelpText.stunt);
        break;
      case CharHelpType.problem:
        _showBottomSheet(context, CharacterHelpText.problem);
        break;
      default:
        return;
    }
  }

  // Приватные методы

  void _saveAspects() {
    List<String> newAspects = List.from(state.character.aspects);

    for (int i = 0; i < state.aspectControllers.length; i++) {
      newAspects[i] = state.aspectControllers[i].text;
    }

    state = state.copyWith(
        character: state.character.copyWith(aspects: newAspects));
  }

  void _saveStuntsDescriptions() {
    List<StuntEntity> newStunts = List.from(state.character.stunts);

    for (int i = 0; i < state.stuntControllers.length; i++) {
      newStunts[i] =
          newStunts[i].copyWith(description: state.stuntControllers[i].text);
    }

    CharacterEntity newCharacter = state.character.copyWith(stunts: newStunts);

    state = state.copyWith(character: newCharacter);
  }

  void _saveName() {
    state = state.copyWith(
        character: state.character.copyWith(name: state.nameController.text));
  }

  void _saveDescription() {
    state = state.copyWith(
        character: state.character
            .copyWith(description: state.descriptionController.text));
  }

  void _saveConcept() {
    state = state.copyWith(
        character:
            state.character.copyWith(concept: state.conceptController.text));
  }

  void _saveProblem() {
    state = state.copyWith(
        character:
            state.character.copyWith(problem: state.problemController.text));
  }

  bool _checkCharacterComplete(
      BuildContext context, CharacterEntity character) {
    dev.log('check character: $character');

    if (character.name.isEmpty) {
      _showBottomSheet(context, 'Напишите имя персонажа');
      return false;
    }

    if (character.concept.isEmpty) {
      _showBottomSheet(context, 'Напишите концепт');
      return false;
    }

    if (character.skills.any((skill) => skill.value == null)) {
      dev.log('подход равен null');
      _showBottomSheet(context, 'Выберите скиллы');

      return false;
    }

    return true;
  }

  void _updateAvailableSkillList() {
    List<int?> currentAvailableSkillList = [..._defaultAvailableSkillList];

    for (final skill in state.character.skills) {
      if (skill.value != null) {
        currentAvailableSkillList.remove(skill.value);
      }
    }

    dev.log('avaibale skills: $currentAvailableSkillList');

    state = state.copyWith(skillAvailableList: currentAvailableSkillList);
  }

  Future<pw.Document> _createPDF(CharacterEntity character) async {
    final myTheme = pw.ThemeData.withFont(
        base: pw.Font.ttf(
            await rootBundle.load("assets/fonts/Roboto-Regular.ttf")),
        bold:
            pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf")));

    final pdf = pw.Document(theme: myTheme);

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => AppPdfWidget(character: character),
    ));

    return pdf;
  }

  void _updateControllersText(CharacterEntity character) {
    state
      ..nameController.text = character.name
      ..conceptController.text = character.concept
      ..descriptionController.text = character.description
      ..problemController.text = character.problem;

    for (int i = 0; i < state.aspectControllers.length; i++) {
      state.aspectControllers[i].text = character.aspects[i];
    }

    for (int i = 0; i < state.stuntControllers.length; i++) {
      state.stuntControllers[i].text = character.stunts[i].description ?? '';
    }
  }

  void _showBottomSheet(BuildContext context, String text) {
    showModalBottomSheet(
        context: context, builder: (context) => AppBottomSheet(text: text));
  }

  Future<void> _saveImage(PlatformFile file) async {
    final res = await _saveFileUC(file);

    res.fold((failure) => null, (path) {
      state = state.copyWith(character: state.character.copyWith(image: path));
      _updateCharacterUC(state.character);
    });
  }
}

enum CharHelpType { name, concept, description, skill, aspect, stunt, problem }
