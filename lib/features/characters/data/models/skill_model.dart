part of '../mapper/models_mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class SkillModel extends SkillEntity with SkillModelMappable {
  SkillModel({required SkillType type, int? value})
      : super(type: type, value: value);

  SkillEntity toEntity() {
    return SkillEntity(
      type: type,
      value: value,
    );
  }

  factory SkillModel.fromEntity(SkillEntity entity) {
    return SkillModel(
      type: entity.type,
      value: entity.value,
    );
  }

  factory SkillModel.fromSQLite(Map<String, dynamic> data) {
    return SkillModel(
      type: SkillTypeMapper.fromValue(data['type']),
      value: data['value'],
    );
  }
}
