part of '../mapper/entities_mapper.dart';

@MappableClass()
class SkillEntity with SkillEntityMappable {
  final SkillType type;
  final int? value;

  SkillEntity({required this.type, this.value});
}

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum SkillType { careful, clever, flashy, forceful, quick, sneaky }

extension SkillTypeExtension on SkillType {
  String toLabel() {
    switch (this) {
      case SkillType.careful:
        return 'Аккуратный';
      case SkillType.clever:
        return 'Умный';
      case SkillType.flashy:
        return 'Эфектный';
      case SkillType.forceful:
        return 'Сильный';
      case SkillType.quick:
        return 'Проворный';
      case SkillType.sneaky:
        return 'Хитрый';
    }
  }

}
