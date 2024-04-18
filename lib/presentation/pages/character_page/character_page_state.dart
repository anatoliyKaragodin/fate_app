part of '../../../domain/mapper/models_mapper.dart';

@MappableClass()
class CharacterPageState with CharacterPageStateMappable{
  final List<CharacterEntity> characters;
  final bool isEditing;

  const CharacterPageState({required this.characters, required this.isEditing});
}

