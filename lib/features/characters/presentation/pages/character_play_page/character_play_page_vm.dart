import 'dart:math';

import 'package:fate_app/core/router/router.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'dart:developer' as dev;

import '../../../../../core/di/di_container.dart';
import '../../widgets/common/app_roll_dice_widget.dart';

final characterPlayPageVMProvider =
    StateNotifierProvider<CharacterPlayPageVm, CharacterPlayPageState>(
        (ref) => CharacterPlayPageVm(getIt()));

class CharacterPlayPageVm extends StateNotifier<CharacterPlayPageState> {
  CharacterPlayPageVm(this._updateCharacterUC)
      : super(CharacterPlayPageState(
            isScreenLocked: false,
            consequencesControllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController()
            ],
            character: CharacterEntity.empty(),
            isCompact: false));

  final UpdateCharacter _updateCharacterUC;

  final random = Random();

  void initCharacter(CharacterEntity character) {
    state = state.copyWith(character: character);

    for (int i = 0; i < character.consequences.length; i++) {
      state.consequencesControllers[i].text = character.consequences[i] ?? '';
    }
  }

  void goBack(WidgetRef ref) {
    ref
        .read(charactersListPageViewProvider.notifier)
        .updateCharacter(state.character);

    WakelockPlus.disable();

    RouterHelper.router.go(RouterHelper.allCharactersPath);
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

  void onTapSkill(BuildContext context, int index) {
    if (state.character.skills[index].value == null) return;

    showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AppRollDiceWidget(
        skill: state.character.skills[index],
        onCancel: () => RouterHelper.router.pop(),
        onRoll: (value) {
          RouterHelper.router.pop();
          _showRollSkill(
              state.character.skills[index].type.toLabel(), value + 4);
        },
      ),
    );
    dev.log('tap skill $index');
  }

  void _showRollSkill(String skillLabel, int diceCount) {
    List<FateDiceResult> dicesResult = [];

    if (diceCount > 0) {
      for (int i = 0; i < diceCount; i++) {
        final diceRoll = FateDiceResult.values[random.nextInt(3)];
        dicesResult.add(diceRoll);
      }
    }

    final successCount =
        dicesResult.where((result) => result == FateDiceResult.success).length;
    final failCount =
        dicesResult.where((result) => result == FateDiceResult.fail).length;

    showModalBottomSheet(
        context: RouterHelper.parentNavigatorKey.currentContext!,
        builder: (context) {
          return AppBottomSheet(
              text:
                  '$skillLabel подход. Успехов: $successCount, Провалов: $failCount, Итог: ${successCount - failCount}');
        });
  }
}

enum FateDiceResult { success, fail, empty }
