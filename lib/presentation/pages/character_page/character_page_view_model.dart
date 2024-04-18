import 'package:fate_app/domain/di/di_container.dart';
import 'package:fate_app/domain/mapper/models_mapper.dart';
import 'package:fate_app/domain/usecases/get_characters.dart';
import 'package:fate_app/domain/usecases/save_new_character.dart';
import 'package:fate_app/domain/usecases/update_character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final characterPageViewProvider =
    StateNotifierProvider<CharacterPageViewModel, CharacterPageState>(
        (ref) => CharacterPageViewModel(getIt.get<GetCharacters>(),
            getIt.get<SaveNewCharacter>(), getIt.get<UpdateCharacter>()));

class CharacterPageViewModel extends StateNotifier<CharacterPageState> {
  final GetCharacters _getCharacters;
  final SaveNewCharacter _saveNewCharacter;
  final UpdateCharacter _updateCharacter;

  CharacterPageViewModel(
      this._getCharacters, this._saveNewCharacter, this._updateCharacter)
      : super(const CharacterPageState(characters: [], isEditing: false)) {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    // state = await _getCharacters.get();
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
