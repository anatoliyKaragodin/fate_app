part of 'mapper/entities_mapper.dart';

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
        return 'Эффектный';
      case SkillType.forceful:
        return 'Сильный';
      case SkillType.quick:
        return 'Проворный';
      case SkillType.sneaky:
        return 'Хитрый';
    }
  }

  String toLabelMin() {
    switch (this) {
      case SkillType.careful:
        return 'Акк';
      case SkillType.clever:
        return 'Умн';
      case SkillType.flashy:
        return 'Эфф';
      case SkillType.forceful:
        return 'Сил';
      case SkillType.quick:
        return 'Пров';
      case SkillType.sneaky:
        return 'Хитр';
    }
  }
}
