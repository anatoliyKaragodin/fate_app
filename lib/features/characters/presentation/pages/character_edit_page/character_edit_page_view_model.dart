import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_ai_draft.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_field_regen_patch.dart';
import 'package:fate_app/features/character_ai/domain/entities/character_regen_field.dart';
import 'package:fate_app/features/avatar_ai/domain/usecases/generate_character_avatar.dart';
import 'package:fate_app/features/characters/domain/character_field_limits.dart';
import 'package:fate_app/features/character_ai/domain/usecases/generate_character_draft.dart';
import 'package:fate_app/features/character_ai/domain/usecases/regenerate_character_field.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/utils/character_help_text.dart';
import 'package:fate_app/features/characters/presentation/utils/pollinations_avatar_prompt.dart';
import 'package:fate_app/features/file_management/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_management/domain/usecases/copy_file.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/utils/character_pdf_document_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
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
            getIt.get<DeleteFile>(),
            getIt.get<GenerateCharacterDraft>(),
            getIt.get<RegenerateCharacterField>(),
            getIt.get<GenerateCharacterAvatar>(),
        ));

class CharacterEditPageViewModel extends StateNotifier<CharacterEditPageState> {
  final SaveNewCharacter _saveNewCharacterUC;
  final UpdateCharacter _updateCharacterUC;
  final SavePdf _savePdfUC;
  final CopyFile _copyFileUC;
  final DeleteFile _deleteFileUC;
  final GenerateCharacterDraft _generateCharacterDraft;
  final RegenerateCharacterField _regenerateCharacterField;
  final GenerateCharacterAvatar _generateCharacterAvatar;

  CharacterEditPageViewModel(
      this._saveNewCharacterUC,
      this._updateCharacterUC,
      this._savePdfUC,
      this._copyFileUC,
      this._deleteFileUC,
      this._generateCharacterDraft,
      this._regenerateCharacterField,
      this._generateCharacterAvatar)
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

  Future<pw.Document> createPdf() => buildCharacterPdfDocument(state.character);

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

  /// Запрос к ИИ и применение черновика к текущему персонажу в стейте.
  Future<Either<Failure, void>> generateCharacterWithAi(
    String userHint, {
    CancelToken? cancelToken,
  }) async {
    final trimmed = userHint.trim();
    if (trimmed.isEmpty) {
      return const Left(UnknownFailure(message: 'Опишите идею персонажа.'));
    }
    dev.log('[AI] VM: вызов GenerateCharacterDraft…');
    final result = await _generateCharacterDraft(
      GenerateCharacterDraftParams(
        userHint: trimmed,
        cancelToken: cancelToken,
      ),
    );
    dev.log('[AI] VM: use case вернул ${result.isLeft() ? "ошибку" : "черновик"}');
    return result.fold<Either<Failure, void>>(
      Left.new,
      (draft) {
        dev.log('[AI] VM: applyAiDraft…');
        applyAiDraft(draft);
        dev.log('[AI] VM: applyAiDraft готово');
        return const Right(null);
      },
    );
  }

  String buildSheetContextForAi() {
    final c = state.character;
    final aspects = c.aspects.join('; ');
    final stunts = c.stunts
        .map((s) => '${s.type.toLabel()}: ${s.description ?? ''}')
        .join('; ');
    return '''
Имя: ${c.name}
Концепт: ${c.concept}
Проблема: ${c.problem}
Описание: ${c.description}
Аспекты: $aspects
Трюки: $stunts
'''.trim();
  }

  Future<Either<Failure, void>> regenerateCharacterFieldWithAi({
    required CharacterRegenField field,
    required String hint,
  }) async {
    final stuntLabel = field.stuntIndex != null
        ? state.character.stunts[field.stuntIndex!].type.toLabel()
        : null;
    final result = await _regenerateCharacterField(
      RegenerateCharacterFieldParams(
        field: field,
        userHint: hint,
        sheetContext: buildSheetContextForAi(),
        stuntTypeLabel: stuntLabel,
      ),
    );
    return result.fold(Left.new, (patch) {
      applyFieldRegenPatch(patch);
      return const Right(null);
    });
  }

  void applyFieldRegenPatch(CharacterFieldRegenPatch patch) {
    final c = state.character;
    switch (patch.field) {
      case CharacterRegenField.name:
        state = state.copyWith(character: c.copyWith(name: patch.text));
        break;
      case CharacterRegenField.concept:
        state = state.copyWith(character: c.copyWith(concept: patch.text));
        break;
      case CharacterRegenField.problem:
        state = state.copyWith(character: c.copyWith(problem: patch.text));
        break;
      case CharacterRegenField.description:
        state = state.copyWith(character: c.copyWith(description: patch.text));
        break;
      case CharacterRegenField.aspect0:
      case CharacterRegenField.aspect1:
      case CharacterRegenField.aspect2:
        final i = patch.field.aspectIndex!;
        final old = c.aspects;
        final next = <String>[
          for (var j = 0; j < 3; j++)
            j == i ? patch.text : (j < old.length ? old[j] : ''),
        ];
        state = state.copyWith(character: c.copyWith(aspects: next));
        break;
      case CharacterRegenField.stunt0:
      case CharacterRegenField.stunt1:
      case CharacterRegenField.stunt2:
        final i = patch.field.stuntIndex!;
        final stunts = [...c.stunts];
        stunts[i] = stunts[i].copyWith(description: patch.text);
        state = state.copyWith(character: c.copyWith(stunts: stunts));
        break;
    }
  }

  void applyAiDraft(CharacterAiDraft draft) {
    final skills = [
      for (final s in state.character.skills)
        s.copyWith(value: draft.skills[s.type]),
    ];
    final stunts = [
      for (var i = 0; i < 3; i++)
        state.character.stunts[i].copyWith(
          type: draft.stunts[i].type,
          description: draft.stunts[i].description,
        ),
    ];
    final character = state.character.copyWith(
      name: draft.name,
      concept: draft.concept,
      problem: draft.problem,
      description: mergeAppearanceIntoDescription(
        appearance: draft.appearance,
        descriptionBody: draft.description,
      ),
      aspects: draft.aspects,
      skills: skills,
      stunts: stunts,
    );
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

  Future<void> importAvatar(String filePath) async {
    final res = await _copyFileUC(filePath);

    res.fold((failure) => null, (path) {
      if (state.character.image != null) {
        _deleteFileUC(state.character.image!);
      }
      state = state.copyWith(character: state.character.copyWith(image: path));
    });
  }

  /// Портрет через SiliconFlow по текущим полям листа (передавайте текст из контроллеров).
  Future<Either<Failure, void>> generateAvatar({
    required String name,
    required String concept,
    required String problem,
    required String description,
    CancelToken? cancelToken,
  }) async {
    final synthetic = state.character.copyWith(
      name: name,
      concept: concept,
      problem: problem,
      description: description,
    );
    if (!hasPollinationsAvatarPromptMaterial(synthetic)) {
      return const Left(UnknownFailure(
        message:
            'Укажите имя, концепт или описание — по ним соберётся промпт для аватара.',
      ));
    }
    final prompt = buildPollinationsAvatarPrompt(synthetic);
    final result = await _generateCharacterAvatar(
      GenerateCharacterAvatarParams(
        prompt: prompt,
        cancelToken: cancelToken,
      ),
    );
    return result.fold<Future<Either<Failure, void>>>(
      (f) async => Left(f),
      (path) async {
        final old = state.character.image;
        if (old != null) {
          await _deleteFileUC(old);
        }
        state = state.copyWith(character: state.character.copyWith(image: path));
        return const Right(null);
      },
    );
  }
}

enum CharHelpType { name, concept, description, skill, aspect, stunt, problem }
