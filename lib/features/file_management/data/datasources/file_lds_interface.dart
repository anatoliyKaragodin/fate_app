import 'package:fate_app/features/file_management/domain/usecases/save_pdf.dart';

abstract class FileLDS {
  Future<String?> copy(String filePath);

  Future<void> savePdf(PdfParams params);

  Future<void> delete(String path);
}
