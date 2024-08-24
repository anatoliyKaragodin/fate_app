import 'package:fate_app/core/error/exeption.dart'; // Убедитесь, что у вас есть этот импорт
import 'package:fate_app/features/file_managment/data/datasources/file_lds_intrerface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:developer' as dev;

import '../../../domain/usecases/save_pdf.dart';

class FileLdsImpl implements FileLDS {
  @override
  Future<String?> save(PlatformFile file) async {
    try {
      if (file.path == null) {
        throw CacheException();
      }

      final directory = await getApplicationDocumentsDirectory();

      String newFilePath = '${directory.path}/${file.name}';

      int counter = 1;
      while (await File(newFilePath).exists()) {
        final fileNameWithoutExtension = file.name.split('.').first;
        final fileExtension = file.name.split('.').last;
        newFilePath =
            '${directory.path}/$fileNameWithoutExtension ($counter).$fileExtension';
        counter++;
      }

      final savedFile = File(newFilePath);
      await File(file.path!).copy(savedFile.path);

      return savedFile.path;
    } catch (e) {
      throw CacheException();
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
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> delete(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
