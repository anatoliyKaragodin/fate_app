import 'dart:io';

import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

/// Лист персонажа для PDF (A4). Секции, отступы и типографика согласованы для печати.
class AppPdfWidget extends StatelessWidget {
  AppPdfWidget({
    required this.character,
  });

  final CharacterEntity character;

  static const double _pageW = 595;
  static const double _pageH = 842;
  /// Без полей — максимум места под контент; при печати край может обрезаться.
  static const EdgeInsets _pageMargin = EdgeInsets.zero;

  static const double _radius = 6;
  static const double _bodySize = 9.5;
  static const double _labelSize = 9;
  static const double _titleSize = 18;
  static const double _subtitleSize = 10.5;

  @override
  Widget build(Context context) {
    final theme = Theme.of(context);
    final bodyStyle = theme.defaultTextStyle.copyWith(fontSize: _bodySize);
    final labelStyle = bodyStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: PdfColors.grey800,
      fontSize: _labelSize,
    );
    final mutedStyle =
        bodyStyle.copyWith(color: PdfColors.grey600, fontSize: _labelSize);

    final nonEmptyAspects =
        character.aspects.where((a) => a.isNotEmpty).toList();
    final nonEmptyStunts = character.stunts
        .where((s) => s.description?.isNotEmpty ?? false)
        .toList();

    return SizedBox(
      width: _pageW,
      height: _pageH,
      child: Padding(
        padding: _pageMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(bodyStyle),
            SizedBox(height: 14),
            Container(height: 1, color: PdfColors.grey400),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildSkillsCard(bodyStyle, labelStyle),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildLabeledBlock(
                        'Проблема',
                        character.problem.isEmpty ? '—' : character.problem,
                        bodyStyle,
                        labelStyle,
                      ),
                      SizedBox(height: 10),
                      _buildFateAndStressRow(bodyStyle, labelStyle, mutedStyle),
                    ],
                  ),
                ),
              ],
            ),
            if (nonEmptyAspects.isNotEmpty) ...[
              SizedBox(height: 12),
              _sectionLabel('Аспекты', labelStyle),
              SizedBox(height: 6),
              _buildAspectsList(nonEmptyAspects, bodyStyle, mutedStyle),
            ],
            if (nonEmptyStunts.isNotEmpty) ...[
              SizedBox(height: 12),
              _sectionLabel('Трюки', labelStyle),
              SizedBox(height: 6),
              _buildStuntsList(nonEmptyStunts, bodyStyle),
            ],
            SizedBox(height: 12),
            _sectionLabel('Последствия', labelStyle),
            SizedBox(height: 6),
            _buildConsequencesRow(bodyStyle, mutedStyle),
            SizedBox(height: 12),
            _sectionLabel('Описание', labelStyle),
            SizedBox(height: 6),
            Expanded(
              child: _buildDescriptionBox(character.description, bodyStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextStyle bodyStyle) {
    final hasImage =
        character.image != null && File(character.image!).existsSync();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasImage)
          SizedBox(
            width: 96,
            height: 96,
            child: ClipRRect(
              horizontalRadius: _radius,
              verticalRadius: _radius,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PdfColors.grey400, width: 0.75),
                ),
                child: Image(
                  MemoryImage(File(character.image!).readAsBytesSync()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        if (hasImage) SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name.isEmpty ? 'Без имени' : character.name,
                style: TextStyle(
                  fontSize: _titleSize,
                  fontWeight: FontWeight.bold,
                  color: PdfColors.grey900,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Концепция',
                style: bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: PdfColors.grey700,
                  fontSize: _labelSize,
                ),
              ),
              SizedBox(height: 2),
              Text(
                character.concept.isEmpty ? '—' : character.concept,
                style: bodyStyle.copyWith(fontSize: _subtitleSize),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsCard(TextStyle bodyStyle, TextStyle labelStyle) {
    final half = character.skills.length ~/ 2;
    final left = character.skills.sublist(0, half);
    final right = character.skills.sublist(half);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey500, width: 0.75),
        borderRadius: BorderRadius.circular(_radius),
        color: PdfColors.grey100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Подходы', style: labelStyle),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _skillColumn(left, bodyStyle)),
              SizedBox(width: 10),
              Expanded(child: _skillColumn(right, bodyStyle)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillColumn(List<SkillEntity> skills, TextStyle bodyStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final s in skills)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    s.type.toLabel(),
                    style: bodyStyle,
                    maxLines: 2,
                  ),
                ),
                Text(
                  s.value?.toString() ?? '—',
                  style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLabeledBlock(
    String label,
    String value,
    TextStyle bodyStyle,
    TextStyle labelStyle,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey400, width: 0.75),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          SizedBox(height: 4),
          Text(value, style: bodyStyle),
        ],
      ),
    );
  }

  Widget _buildFateAndStressRow(
    TextStyle bodyStyle,
    TextStyle labelStyle,
    TextStyle mutedStyle,
  ) {
    final tokens = character.fateTokens ?? 0;
    final stress = character.stress;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColors.grey400, width: 0.75),
              borderRadius: BorderRadius.circular(_radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Жетоны судьбы', style: labelStyle),
                SizedBox(height: 6),
                Text('$tokens / 3', style: bodyStyle),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(3, (i) {
                    final filled = i < tokens;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _circle(14, filled: filled),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColors.grey400, width: 0.75),
              borderRadius: BorderRadius.circular(_radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Стресс', style: labelStyle),
                SizedBox(height: 6),
                Text(
                  stress == null || stress == 0
                      ? 'нет отметок'
                      : '$stress из 3',
                  style: mutedStyle,
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(3, (i) {
                    final filled = stress != null && i < stress;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _circle(14, filled: filled, mark: filled),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _circle(double size, {required bool filled, bool mark = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled ? PdfColors.grey700 : PdfColors.white,
        border: Border.all(
          color: PdfColors.grey600,
          width: 0.75,
        ),
      ),
      alignment: Alignment.center,
      child: mark
          ? Text(
              '✕',
              style: TextStyle(
                fontSize: size * 0.45,
                color: PdfColors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  Widget _sectionLabel(String text, TextStyle labelStyle) {
    return Text(text, style: labelStyle.copyWith(fontSize: _labelSize + 0.5));
  }

  Widget _buildAspectsList(
    List<String> aspects,
    TextStyle bodyStyle,
    TextStyle mutedStyle,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey400, width: 0.75),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < aspects.length; i++) ...[
            if (i > 0) SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22,
                  child: Text('${i + 1}.', style: mutedStyle),
                ),
                Expanded(child: Text(aspects[i], style: bodyStyle)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStuntsList(List<StuntEntity> stunts, TextStyle bodyStyle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey400, width: 0.75),
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < stunts.length; i++) ...[
            if (i > 0) SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: bodyStyle,
                children: [
                  TextSpan(
                    text: '${stunts[i].type.toLabel()}: ',
                    // Курсив в pdf без отдельного italic-шрифта даёт «пустые» глифы.
                    style: bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PdfColors.grey800,
                    ),
                  ),
                  TextSpan(text: stunts[i].description ?? ''),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConsequencesRow(TextStyle bodyStyle, TextStyle mutedStyle) {
    final list = character.consequences;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (i) {
        final raw = i < list.length ? list[i] : null;
        final text = (raw == null || raw.isEmpty) ? '' : raw;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: i > 0 ? 8 : 0),
            child: Container(
              height: 52,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: PdfColors.grey400, width: 0.75),
                borderRadius: BorderRadius.circular(_radius),
              ),
              alignment: Alignment.topLeft,
              child: Text(
                text.isEmpty ? ' ' : text,
                style: text.isEmpty ? mutedStyle : bodyStyle,
                maxLines: 4,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDescriptionBox(String description, TextStyle bodyStyle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: PdfColors.grey400, width: 0.75),
        borderRadius: BorderRadius.circular(_radius),
        color: PdfColors.grey100,
      ),
      child: description.isEmpty
          ? Text('—', style: bodyStyle.copyWith(color: PdfColors.grey500))
          : Text(description, style: bodyStyle),
    );
  }
}
