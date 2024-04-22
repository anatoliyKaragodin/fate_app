part of '../mapper/entities_mapper.dart';

@MappableClass()
class CharacterEntity with CharacterEntityMappable {
  final String remoteId;
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

  CharacterModel toModel() {
    return CharacterModel(
      remoteId: remoteId,
      localeId: localeId,
      name: name,
      description: description,
      image: image,
    );
  }
}
