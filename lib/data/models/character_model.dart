import 'package:dart_mappable/dart_mappable.dart';
import 'package:fate_app/domain/mapper/models_mapper.dart';

part 'character_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CharacterModel with CharacterModelMappable {
  final int remoteId;
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
