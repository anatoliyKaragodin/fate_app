import 'dart:io';

import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';
import 'package:pdf/widgets.dart';

/// AppPdfWidget - это виджет, который генерирует PDF-документ для персонажа.
///
/// Этот виджет используется для отображения информации о персонаже в формате PDF,
/// включая его имя, концепцию, навыки, аспекты и другие характеристики.

class AppPdfWidget extends StatelessWidget {
  AppPdfWidget({
    required this.character,
  });

  /// Объект персонажа, содержащий информацию для отображения.
  final CharacterEntity character;

  /// Ширина PDF-документа в пунктах (A4).
  static const double _width = 595;

  /// Высота PDF-документа в пунктах (A4).
  static const double _height = 842;

  @override
  Widget build(Context context) {
    // Получение непустых аспектов персонажа
    final nonEmptyAspects =
        character.aspects.where((aspect) => aspect.isNotEmpty).toList();

    // Получение непустых трюков персонажа
    final nonEmptyStunts = character.stunts
        .where((stunt) => stunt.description?.isNotEmpty ?? false)
        .toList();

    return Container(
        width: _width,
        height: _height,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                // Отображение изображения персонажа, если оно доступно
                if (character.image != null)
                  SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                          horizontalRadius: 8,
                          verticalRadius: 8,
                          child: Image(
                            MemoryImage(
                              File(character.image!).readAsBytesSync(),
                            ),
                          ))),
                SizedBox(width: 8),
                SizedBox(
                    width: 350,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeaderAndText(header: 'Имя:', text: character.name),
                          SizedBox(height: 4),
                          _HeaderAndText(
                              header: 'Концепция:', text: character.concept),
                        ]))
              ]),
              SizedBox(height: 8),
              _HeaderAndText(header: 'Подходы:'),
              SizedBox(height: 4),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        width: 100,
                        child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Table(
                                tableWidth: TableWidth.max,
                                children: List.generate(
                                    character.skills.length,
                                    (index) => TableRow(children: [
                                          Text(character.skills[index].type
                                              .toLabel()),
                                          Text(character.skills[index].value
                                              .toString())
                                        ]))))),
                    SizedBox(width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 350,
                              child: _HeaderAndText(
                                  header: 'Проблема:',
                                  text: character.problem)),
                          SizedBox(height: 8),
                          Row(children: [
                            _HeaderAndText(header: 'Жетоны судьбы:'),
                            SizedBox(width: 20),
                            SizedBox(
                                width: 100,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        3,
                                        (index) => Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all()),
                                            child: Text('')))))
                          ])
                        ])
                  ]),
              SizedBox(height: 8),
              _HeaderAndText(header: 'Аспекты:'),
              SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          nonEmptyAspects.length,
                          (index) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(nonEmptyAspects[index]))))),
              SizedBox(height: 8),
              _HeaderAndText(header: 'Трюки:'),
              SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          nonEmptyStunts.length,
                          (index) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                  '(${nonEmptyStunts[index].type.toLabel()}) ${nonEmptyStunts[index].description!}'))))),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _HeaderAndText(header: 'Стресс:'),
                SizedBox(width: 8),
                SizedBox(
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            3,
                            (index) => Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                                child: Text('')))))
              ]),
              SizedBox(height: 8),
              SizedBox(
                child: Column(children: [
                  _HeaderAndText(header: 'Последствия:'),
                  SizedBox(height: 4),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          3,
                          (index) => Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all()),
                              ))),
                ]),
              ),
              SizedBox(height: 8),
              _HeaderAndText(header: 'Описание:'),
              SizedBox(height: 4),
              Text(character.description)
            ]));
  }
}

class _HeaderAndText extends StatelessWidget {
  final String header;

  final String? text;

  _HeaderAndText({required this.header, this.text});

  @override
  Widget build(Context context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '$header ', style: TextStyle(fontWeight: FontWeight.bold)),
          if (text != null) TextSpan(text: text),
        ],
      ),
    );
  }
}
