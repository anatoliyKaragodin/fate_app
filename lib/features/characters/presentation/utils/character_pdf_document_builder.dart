import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/presentation/widgets/common/app_pdf_widget.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Единая сборка листа персонажа в PDF (экран редактирования и игры).
Future<pw.Document> buildCharacterPdfDocument(CharacterEntity character) async {
  final notoSans = pw.Font.ttf(await rootBundle.load(
      'assets/fonts/NotoSans-VariableFont_wdth,wght.ttf'));
  final theme = pw.ThemeData.withFont(base: notoSans, bold: notoSans);

  final pdf = pw.Document(theme: theme);

  pdf.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) => AppPdfWidget(character: character),
  ));

  return pdf;
}
