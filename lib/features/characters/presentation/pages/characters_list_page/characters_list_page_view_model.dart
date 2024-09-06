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
      : super(const CharactersListPageState(
            characters: [], isEditing: false, sortType: SortType.no)) {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final result = await _getCharactersUC(null);

    result.fold((failure) {
      dev.log('loading error');
    }, (characters) {
      // dev.log('load characters: $characters');

      state = state.copyWith(characters: characters);

      sortBy(state.sortType.toLabel());
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

      sortBy(state.sortType.toLabel());
    }
  }

  void sortBy(String? value) {
    List<CharacterEntity> characters = [...state.characters];

    SortType? sortBy;

    if (value == SortType.no.toLabel()) {
      characters = _sortByLocalId(characters);
      sortBy = SortType.no;
    } else if (value == SortType.name.toLabel()) {
      characters = _sortByName(characters);
      sortBy = SortType.name;
    } else if (value == SortType.createdAt.toLabel()) {
      characters = _sortByCreatedAt(characters);
      sortBy = SortType.createdAt;
    } else if (value == SortType.updatedAt.toLabel()) {
      characters = _sortByUpdatedAt(characters);
      sortBy = SortType.updatedAt;
    }

    state = state.copyWith(characters: characters, sortType: sortBy);
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

    sortBy(state.sortType.toLabel());

    _deleteCharacterUC(character.localeId!);

    if (character.image != null) {
      _deleteFileUC(character.image!);
    }
  }

  List<CharacterEntity> _sortByName(List<CharacterEntity> characters) {
    characters.sort((a, b) => a.name.compareTo(b.name));

    return characters;
  }

  List<CharacterEntity> _sortByCreatedAt(List<CharacterEntity> characters) {
    characters.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return a.createdAt!.compareTo(b.createdAt!) * -1;
    });

    return characters;
  }

  List<CharacterEntity> _sortByUpdatedAt(List<CharacterEntity> characters) {
    characters.sort((a, b) {
      if (a.updatedAt == null && b.updatedAt == null) return 0;
      if (a.updatedAt == null) return 1;
      if (b.updatedAt == null) return -1;
      return a.updatedAt!.compareTo(b.updatedAt!) * -1;
    });

    return characters;
  }

  List<CharacterEntity> _sortByLocalId(List<CharacterEntity> characters) {
    characters.sort((a, b) => a.localeId!.compareTo(b.localeId!));

    return characters;
  }
}

enum SortType { no, name, createdAt, updatedAt }

extension SortTypeExtention on SortType {
  String? toLabel() {
    switch (this) {
      case SortType.no:
        return '';
      case SortType.name:
        return 'имени';
      case SortType.createdAt:
        return 'созданию';
      case SortType.updatedAt:
        return 'обновлению';
      default:
        return null;
    }
  }
}
