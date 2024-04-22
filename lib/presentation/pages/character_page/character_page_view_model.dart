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
        super(CharacterPageState(
            character: const CharacterEntity(
                name: '',
                description: '',
                remoteId: '',
                localeId: 0,
                image: ''),
            nameController: TextEditingController(),
            descriptionController: TextEditingController(),
            conceptController: TextEditingController(),
            problemController: TextEditingController(),
            aspectsControllers: [
              TextEditingController(),
              TextEditingController(),
              TextEditingController()
            ],
            skills: [
              null,
              null,
              null,
              null,
              null,
              null
            ],
            stuntsControllers: [
              TextEditingController(),
            ]));

  void changeName() {
    final name = state.nameController.text;
    state = state.copyWith(character: state.character.copyWith(name: name));
    dev.log('Name changed to $name');
  }

  void saveCharacter() {
    final character = state.character;
    _saveNewCharacter.save(character);
    dev.log('Character saved: $character');
  }

  void goBack(BuildContext context) {
    context.go('/characters');
  }

  void saveAspect(int index) {}

  void saveStunt(int index) {}

  void saveSkill(int index, String? value) {
    if (value == null) return;

    List<int?> skills = List.from(state.skills);

    dev.log(skills.toString());

    skills[index] = int.tryParse(value);

    state = state.copyWith(skills: skills);
  }
}
