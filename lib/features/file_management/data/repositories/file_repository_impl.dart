import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/file_management/data/datasources/file_lds_intrerface.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_management/domain/usecases/save_pdf.dart';

import '../../../../core/error/exeption.dart';

class FileRepositoryImpl implements FileRepository {
  final FileLDS _lds;

  FileRepositoryImpl(this._lds);

  @override
  Future<Either<Failure, String>> copy(String filePath) async {
    try {
      final res = await _lds.copy(filePath);

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
