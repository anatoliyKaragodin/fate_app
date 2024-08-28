import 'package:fate_app/features/file_managment/domain/usecases/save_pdf.dart';
import 'package:file_picker/file_picker.dart';

abstract class FileLDS {
  Future<String?> save(PlatformFile file);

  Future<void> savePdf(PdfParams params);

  Future<void> delete(String path);
}
