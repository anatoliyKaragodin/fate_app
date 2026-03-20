import 'package:fate_app/features/file_management/domain/usecases/save_pdf.dart';

abstract class FileLDS {
  Future<String?> copy(String filePath);

  /// Сохраняет бинарные данные в каталог документов приложения (уникальное имя при коллизии).
  Future<String> saveImageBytes(List<int> bytes, {required String fileName});

  Future<void> savePdf(PdfParams params);

  Future<void> delete(String path);
}
