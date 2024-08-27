import 'package:fate_app/core/di/di_container.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/presentation/mapper/state_mapper.dart';
import 'package:fate_app/features/characters/presentation/pages/character_edit_page/character_edit_page_view_model.dart';
import 'package:fate_app/features/characters/presentation/pages/character_play_page/character_play_page_vm.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_warning_dialog_widget.dart';
import 'package:fate_app/features/file_managment/domain/usecases/delete_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;

import '../../../../../core/router/router.dart';

final charactersListPageViewProvider =
    StateNotifierProvider<CharactersListPageViewModel, CharactersListPageState>(
        (ref) => CharactersListPageViewModel(getIt.get<GetCharacters>(),
            getIt.get<DeleteCharacter>(), getIt.get<DeleteFile>()));

class CharactersListPageViewModel
    extends StateNotifier<CharactersListPageState> {
  final GetCharacters _getCharactersUC;
  final DeleteCharacter _deleteCharacterUC;
  final DeleteFile _deleteFileUC;

  CharactersListPageViewModel(
      this._getCharactersUC, this._deleteCharacterUC, this._deleteFileUC)
      : super(const CharactersListPageState(characters: [], isEditing: false)) {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final result = await _getCharactersUC(null);

    result.fold((failure) {
      dev.log('loading error');
    }, (characters) {
      dev.log('load characters: $characters');

      state = state.copyWith(characters: characters);
    });
  }

  void createCharacter(ref) {
    final character = CharacterEntity.empty();

    ref
        .read(characterEditPageViewModelProvider.notifier)
        .initNewCharacter(character);
    RouterHelper.router.go(RouterHelper.characterEditPath);
  }

  void editCharacter(WidgetRef ref, CharacterEntity character) {
    ref
        .read(characterEditPageViewModelProvider.notifier)
        .initNewCharacter(character);

    RouterHelper.router.go(RouterHelper.characterEditPath);
  }

  void onTapDeleteCharacter(
      BuildContext context, CharacterEntity character) async {
    _showWarning(context, character);
  }

  void goCharacterEditPage(WidgetRef ref, CharacterEntity character) {
    ref.read(characterPlayPageVMProvider.notifier).initCharacter(character);
    RouterHelper.router.go(RouterHelper.characterPlayPath);
  }

  void updateCharacter(CharacterEntity character) {
    List<CharacterEntity> characters = state.characters;

    final index =
        characters.indexWhere((char) => char.localeId == character.localeId);

    if (index != -1) {
      characters[index] = character;
      state = state.copyWith(characters: characters);
    }
  }

// Приватные методы
  void _showWarning(BuildContext context, CharacterEntity character) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return AppWarningDialogWidget(
          button1Text: 'Да',
          button2Text: 'Нет',
          onTapButton1: () {
            _deleteCharacter(character);
            Navigator.of(context).pop();
          },
          onTapButton2: () {
            Navigator.of(context).pop();
          },
          text:
              'Вы уверены, что хотите предать ${character.name.toUpperCase()} забвению?',
          title: 'Внимание!',
        );
      },
    );
  }

  void _deleteCharacter(CharacterEntity character) async {
    if (character.localeId == null) return;

    List<CharacterEntity> characters = [...state.characters];

    characters.removeWhere((char) => char.localeId! == character.localeId!);

    state = state.copyWith(characters: characters);

    _deleteCharacterUC(character.localeId!);

    if (character.image != null) {
      _deleteFileUC(character.image!);
    }
  }
}
