part of '../mapper/entities_mapper.dart';

@MappableClass()
class StuntEntity with StuntEntityMappable {
  final StuntType type;
  final String? description;

  StuntEntity({required this.type, this.description});
}

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum StuntType { oneTime, careful, clever, flashy, forceful, quick, sneaky }

extension StuntTypeExtension on StuntType {
  String toLabel() {
    switch (this) {
      case StuntType.oneTime:
        return 'Разовый';
      case StuntType.careful:
        return '+2 Аккуратный';
      case StuntType.clever:
        return '+2 Умный';
      case StuntType.flashy:
        return '+2 Эфектный';
      case StuntType.forceful:
        return '+2 Сильный';
      case StuntType.quick:
        return '+2 Проворный';
      case StuntType.sneaky:
        return '+2 Хитрый';
    }
  }
}
