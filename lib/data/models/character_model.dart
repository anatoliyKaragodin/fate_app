
part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CharacterModel with CharacterModelMappable {
  final String remoteId;
  final int localeId;
  final String name;
  final String description;
  final String image;

  const CharacterModel(
      {required this.remoteId,
      required this.localeId,
      required this.name,
      required this.description,
      required this.image});

  CharacterEntity toEntity() {
    return CharacterEntity(
      remoteId: remoteId,
      localeId: localeId,
      name: name,
      description: description,
      image: image,
    );
  }
}
