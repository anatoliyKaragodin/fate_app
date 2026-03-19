import 'dart:math';

import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../../core/di/di_container.dart';

final characterPlayPageVMProvider =
    StateNotifierProvider<CharacterPlayPageVm, CharacterPlayPageState>(
        (ref) => CharacterPlayPageVm(getIt()));

class CharacterPlayPageVm extends StateNotifier<CharacterPlayPageState> {
  CharacterPlayPageVm(this._updateCharacterUC)
      : super(CharacterPlayPageState(
            rollResults: [],
            isDiceRollShown: false,
            isScreenLocked: false,
            character: CharacterEntity.empty(),
            isCompact: false));

  final UpdateCharacter _updateCharacterUC;

  final random = Random();

  void initCharacter(CharacterEntity character) {
    state = state.copyWith(character: character);
  }

  void persistCharacterToList(WidgetRef ref) {
    ref
        .read(charactersListPageViewProvider.notifier)
        .updateCharacter(state.character);
  }

  void switchCompactMode() {
    state = state.copyWith(isCompact: !state.isCompact);
  }

  void updateFateTokens(int value) {
    state =
        state.copyWith(character: state.character.copyWith(fateTokens: value));

    _updateCharacterUC(state.character);
  }

  void updateStress(int value) {
    state = state.copyWith(
        character: state.character
            .copyWith(stress: state.character.stress == value ? 0 : value));

    _updateCharacterUC(state.character);
  }

  void updateConsequence(int index, String value) {
    List<String?> consequences = state.character.consequences;

    consequences[index] = value;

    state = state.copyWith(
        character: state.character.copyWith(consequences: consequences));

    _updateCharacterUC(state.character);
  }

  void toggleScreenLock() {
    state = state.copyWith(isScreenLocked: !state.isScreenLocked);

    WakelockPlus.toggle(enable: state.isScreenLocked);
  }

  void showDiceRollSheet() {
    state = state.copyWith(isDiceRollShown: !state.isDiceRollShown);
  }

  void rollSkill(SkillEntity skill, int diceCount) {
    _showRollSkill(skill, diceCount);
  }

  void disableWakelock() {
    WakelockPlus.disable();
  }

  // Приватные методы
  void _showRollSkill(SkillEntity skill, int diceCount) {
    List<FateDiceResult> dicesResult = [];

    for (int i = 0; i < diceCount; i++) {
      final diceRoll = FateDiceResult.values[random.nextInt(3)];
      dicesResult.add(diceRoll);
    }

    final successCount =
        dicesResult.where((result) => result == FateDiceResult.success).length;
    final failCount =
        dicesResult.where((result) => result == FateDiceResult.fail).length;

    List<RollResultEntity> rollResultsList = [...state.rollResults];

    final date = DateTime.now();

    rollResultsList.add(RollResultEntity(
        date: date,
        skill: skill,
        result: successCount - failCount,
        successes: successCount,
        fails: failCount));

    state = state.copyWith(rollResults: rollResultsList, isDiceRollShown: true);
  }
}

enum FateDiceResult { success, fail, empty }
