import 'package:fate_app/core/error/exception.dart';
import 'package:fate_app/features/file_management/data/datasources/file_lds_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:developer' as dev;

import '../../../domain/usecases/save_pdf.dart';

class FileLdsImpl implements FileLDS {
  @override
  Future<String?> copy(String filePath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      String fileName = filePath.split('/').last;

      String newFilePath = '${directory.path}/$fileName';

      int counter = 1;
      while (await File(newFilePath).exists()) {
        final fileNameWithoutExtension = fileName.split('.').first;
        final fileExtension = fileName.split('.').last;
        newFilePath =
            '${directory.path}/$fileNameWithoutExtension ($counter).$fileExtension';
        counter++;
      }

      final savedFile = File(newFilePath);
      await File(filePath).copy(savedFile.path);

      return savedFile.path;
    } catch (e, st) {
      throw CacheException(
          message: 'Failed to copy file', cause: e, stackTrace: st);
    }
  }

  @override
  Future<void> savePdf(PdfParams params) async {
    try {
      String? folderPath = await FilePicker.platform.getDirectoryPath();

      if (folderPath != null) {
        final newFilePath = '$folderPath/FAE - ${params.name}.pdf';

        final pdfFile = File(newFilePath);
        await pdfFile.writeAsBytes(await params.pdf.save(), flush: true);

        dev.log('PDF сохранен: $newFilePath');
      } else {
        throw const CacheException(message: 'Directory is not selected');
      }
    } catch (e, st) {
      if (e is CacheException) rethrow;
      throw CacheException(
          message: 'Failed to save PDF', cause: e, stackTrace: st);
    }
  }

  @override
  Future<void> delete(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      } else {
        throw const CacheException(message: 'File does not exist');
      }
    } catch (e, st) {
      if (e is CacheException) rethrow;
      throw CacheException(
          message: 'Failed to delete file', cause: e, stackTrace: st);
    }
  }
}
