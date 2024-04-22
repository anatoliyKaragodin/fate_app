import 'package:fate_app/domain/di/di_container.dart';
import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/domain/usecases/get_characters.dart';
import 'package:fate_app/domain/usecases/save_new_character.dart';
import 'package:fate_app/domain/usecases/update_character.dart';
import 'package:fate_app/presentation/mapper/state_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CharactersListPageViewProvider =
    StateNotifierProvider<CharactersListPageViewModel, CharactersListPageState>(
        (ref) => CharactersListPageViewModel(getIt.get<GetCharacters>(),
            getIt.get<SaveNewCharacter>(), getIt.get<UpdateCharacter>()));

class CharactersListPageViewModel
    extends StateNotifier<CharactersListPageState> {
  final GetCharacters _getCharacters;
  final SaveNewCharacter _saveNewCharacter;
  final UpdateCharacter _updateCharacter;

  CharactersListPageViewModel(
      this._getCharacters, this._saveNewCharacter, this._updateCharacter)
      : super(const CharactersListPageState(characters: [], isEditing: false)) {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final characters = await _getCharacters.get();
    state = state.copyWith(characters: characters);
  }

  Future<void> addCharacter(CharacterEntity character) async {
    await _saveNewCharacter.save(character);
    // state = [...state, character];
  }

  Future<void> updateCharacter(CharacterEntity character) async {
    await _updateCharacter.update(character);
    // state = state
    //     .map((c) => c.localeId == character.localeId ? character : c)
    //     .toList();
  }
}
