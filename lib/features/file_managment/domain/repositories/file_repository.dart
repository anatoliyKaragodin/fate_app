import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:file_picker/file_picker.dart';

import '../usecases/save_pdf.dart';

abstract class FileRepository {
  Future<Either<Failure, String>> save(PlatformFile file);

  Future<Either<Failure, void>> savePdf(PdfParams params);

  Future<Either<Failure, void>> delete(String path);
}
