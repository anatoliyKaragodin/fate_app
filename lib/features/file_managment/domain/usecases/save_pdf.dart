import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:pdf/widgets.dart';

import '../repositories/file_repository.dart';

class SavePdf extends UseCase<void, PdfParams> {
  final FileRepository repository;

  SavePdf(this.repository);

  @override
  Future<Either<Failure, void>> call(PdfParams params) async {
    return await repository.savePdf(params);
  }
}

class PdfParams {
  final Document pdf;
  final String name;

  PdfParams({required this.pdf, required this.name});
}
