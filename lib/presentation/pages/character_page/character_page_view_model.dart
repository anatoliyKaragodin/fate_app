import 'package:fate_app/domain/mapper/entities_mapper.dart';
import 'package:fate_app/presentation/mapper/state_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;
import 'package:fate_app/domain/usecases/save_new_character.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final characterPageViewModelProvider =
    StateNotifierProvider<CharacterPageViewModel, CharacterPageState>(
        (ref) => CharacterPageViewModel());

class CharacterPageViewModel extends StateNotifier<CharacterPageState> {
  final SaveNewCharacter _saveNewCharacter;

  CharacterPageViewModel()
      : _saveNewCharacter = GetIt.instance.get<SaveNewCharacter>(),
        super(const CharacterPageState(
          character: CharacterEntity(
              name: '',
              description: '',
              skills: [-1, -1, -1, -1, -1, -1],
              concept: '',
              problem: '',
              aspects: [],
              stunts: []),
          skills: [-1, -1, -1, -1, -1, -1],
        ));

  void saveCharacter() {
    final character = state.character;

    if (!_checkCharacterComplete(character)) {
      return;
    }

    _saveNewCharacter.save(character);
    dev.log('Character saved: $character');
  }

  void goBack(BuildContext context) {
    context.go('/characters');
  }

  void saveAspect(int index, String value) {
    List<String> newAspects = List.from(state.character.aspects);
    newAspects[index] = value;
    CharacterEntity newCharacter =
        state.character.copyWith(aspects: newAspects);

    state = state.copyWith(character: newCharacter);
  }

  void saveStunt(int index, String? value) {
    if (value == null) return;

    List<String> newStunts = List.from(state.character.stunts);
    newStunts[index] = value;
    CharacterEntity newCharacter = state.character.copyWith(stunts: newStunts);

    state = state.copyWith(character: newCharacter);
  }

  void saveSkill(int index, String? value) {
    if (value == null) return;

    List<int> skills = List.from(state.skills);

    skills[index] = int.tryParse(value) ?? -1;

    dev.log('save skills: $skills');

    final character = state.character.copyWith(skills: skills);

    state = state.copyWith(skills: skills, character: character);
  }

  void saveName(String value) {
    state = state.copyWith(character: state.character.copyWith(name: value));
    dev.log('Name changed to $value');
  }

  void saveDescription(String value) {
    state =
        state.copyWith(character: state.character.copyWith(description: value));
  }

  void saveConcept(String value) {
    state = state.copyWith(character: state.character.copyWith(concept: value));
  }

  void saveProblem(String value) {
    state = state.copyWith(character: state.character.copyWith(problem: value));
  }

  bool _checkCharacterComplete(CharacterEntity character) {
    dev.log('check character: $character');

    if (character.name.isEmpty) {
      return false;
    }

    if (character.skills.contains(-1)) {
      return false;
    }

    return true;
  }
}
