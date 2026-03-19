part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class StuntModel extends StuntEntity with StuntModelMappable {
  StuntModel({required StuntType type, String? description})
      : super(type: type, description: description);

  StuntEntity toEntity() {
    return StuntEntity(
      type: type,
      description: description,
    );
  }

  factory StuntModel.fromEntity(StuntEntity entity) {
    return StuntModel(
      type: entity.type,
      description: entity.description,
    );
  }

  factory StuntModel.fromSQLite(Map<String, dynamic> data) {
    return StuntModel(
      type: StuntTypeMapper.fromValue(data['type']),
      description: data['description'],
    );
  }
}
