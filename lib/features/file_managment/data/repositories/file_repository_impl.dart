import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/file_managment/data/datasources/file_lds_intrerface.dart';
import 'package:fate_app/features/file_managment/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_pdf.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/error/exeption.dart';

class FileRepositoryImpl implements FileRepository {
  final FileLDS _lds;

  FileRepositoryImpl(this._lds);

  @override
  Future<Either<Failure, String>> save(PlatformFile file) async {
    try {
      final res = await _lds.save(file);

      return Right(res!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> savePdf(PdfParams params) async {
    try {
      await _lds.savePdf(params);

      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> delete(String path) async {
    try {await _lds.delete(path); return const Right(null);} on CacheException {
      return Left(CacheFailure());
    }
  }
}
