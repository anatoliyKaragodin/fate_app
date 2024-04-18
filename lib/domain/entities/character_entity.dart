part of '../mapper/models_mapper.dart';

@MappableClass()
class CharacterEntity with CharacterEntityMappable {
  final int remoteId;
  final int localeId;
  final String name;
  final String description;
  final String image;

  const CharacterEntity(
      {required this.remoteId,
      required this.localeId,
      required this.name,
      required this.description,
      required this.image});
}
