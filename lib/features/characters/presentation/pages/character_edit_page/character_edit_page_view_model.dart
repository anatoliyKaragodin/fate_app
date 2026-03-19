import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/utils/character_help_text.dart';
import 'package:fate_app/features/file_management/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_management/domain/usecases/copy_file.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_pdf_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../../core/di/di_container.dart';
import '../../../../file_management/domain/usecases/save_pdf.dart';

final characterEditPageViewModelProvider =
    StateNotifierProvider<CharacterEditPageViewModel, CharacterEditPageState>(
        (ref) => CharacterEditPageViewModel(
            getIt.get<SaveNewCharacter>(),
            getIt.get<UpdateCharacter>(),
            getIt.get<SavePdf>(),
            getIt.get<CopyFile>(),
            getIt()));

class CharacterEditPageViewModel extends StateNotifier<CharacterEditPageState> {
  final SaveNewCharacter _saveNewCharacterUC;
  final UpdateCharacter _updateCharacterUC;
  final SavePdf _savePdfUC;
  final CopyFile _copyFileUC;
  final DeleteFile _deleteFileUC;

  CharacterEditPageViewModel(this._saveNewCharacterUC, this._updateCharacterUC,
      this._savePdfUC, this._copyFileUC, this._deleteFileUC)
      : super(CharacterEditPageState(
            character: CharacterEntity.empty(),
            skillAvailableList: _defaultAvailableSkillList));

  static const List<int?> _defaultAvailableSkillList = [null, 0, 1, 1, 2, 2, 3];

  Future<bool> saveCharacter(
    WidgetRef ref, {
    required String name,
    required String concept,
    required String problem,
    required String description,
    required List<String> aspects,
    required List<String> stunts,
  }) async {
    final updatedCharacter = state.character.copyWith(
      name: name,
      concept: concept,
      problem: problem,
      description: description,
      aspects: aspects,
      stunts: [
        for (int i = 0; i < state.character.stunts.length; i++)
          state.character.stunts[i].copyWith(
            description: i < stunts.length ? stunts[i] : null,
          ),
      ],
    );

    if (!_isCharacterComplete(updatedCharacter)) {
      return false;
    }

    state = state.copyWith(character: updatedCharacter);

    if (updatedCharacter.localeId != null) {
      await _updateCharacterUC(updatedCharacter);
      dev.log('Character updated: $updatedCharacter');
    } else {
      await _saveNewCharacterUC(updatedCharacter);
      dev.log('Character saved: $updatedCharacter');
    }

    await ref.read(charactersListPageViewProvider.notifier).fetchCharacters();
    return true;
  }

  Future<void> exportPDF(pw.Document pdf) async {
    await _savePdfUC(PdfParams(pdf: pdf, name: state.character.name));
  }

  void goBack() {}

  Future<pw.Document> createPdf() => _createPDF(state.character);

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
    state = state.copyWith(character: character);
    _updateAvailableSkillList();
  }

  String helpText(CharHelpType helpType) {
    switch (helpType) {
      case CharHelpType.name:
        return CharacterHelpText.name;
      case CharHelpType.concept:
        return CharacterHelpText.concept;
      case CharHelpType.description:
        return CharacterHelpText.description;
      case CharHelpType.skill:
        return CharacterHelpText.skill;
      case CharHelpType.aspect:
        return CharacterHelpText.aspect;
      case CharHelpType.stunt:
        return CharacterHelpText.stunt;
      case CharHelpType.problem:
        return CharacterHelpText.problem;
    }
  }

  // Приватные методы
  bool _isCharacterComplete(CharacterEntity character) {
    if (character.name.isEmpty) return false;
    if (character.concept.isEmpty) return false;
    if (character.skills.any((skill) => skill.value == null)) return false;
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

  Future<void> importAvatar(String filePath) async {
    final res = await _copyFileUC(filePath);

    res.fold((failure) => null, (path) {
      if (state.character.image != null) {
        _deleteFileUC(state.character.image!);
      }
      state = state.copyWith(character: state.character.copyWith(image: path));
    });
  }
}

enum CharHelpType { name, concept, description, skill, aspect, stunt, problem }
