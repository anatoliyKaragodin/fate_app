import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';

import '../usecases/save_pdf.dart';

abstract class FileRepository {
  Future<Either<Failure, String>> copy(String filePath);

  Future<Either<Failure, void>> savePdf(PdfParams params);

  Future<Either<Failure, void>> delete(String path);
}
