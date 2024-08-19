
import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/core/usecases/usecase.dart';
import 'package:fate_app/features/file_managment/domain/repositories/file_repository.dart';
import 'package:file_picker/file_picker.dart';


class SaveFile extends UseCase<String?, PlatformFile> {
  final FileRepository repository;

  SaveFile(this.repository);

  @override
  Future<Either<Failure, String>> call(PlatformFile params) async {
    return await repository.save(params);
  }
}

