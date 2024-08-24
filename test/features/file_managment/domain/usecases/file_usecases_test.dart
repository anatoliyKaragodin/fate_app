import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/file_managment/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_managment/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_file.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pdf/widgets.dart';

import 'file_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FileRepository>()])
void main() {
  late FileRepository repository;

  late SaveFile saveFileUC;
  late SavePdf savePdfUC;
  late DeleteFile deleteFileUC;

  final PlatformFile file = PlatformFile(
    name: 'test_file.txt',
    path: '/path/to/test_file.txt',
    bytes: Uint8List(0),
    size: 0,
  );

  final pdfParams = PdfParams(pdf: Document(), name: 'pdf name');

  setUp(() {
    repository = MockFileRepository();

    savePdfUC = SavePdf(repository);
    saveFileUC = SaveFile(repository);
    deleteFileUC = DeleteFile(repository);
  });

  group('SaveFile UC', () {
    test('SaveFile UC (Ok)', () async {
      // Arrange
      when(repository.save(file)).thenAnswer((_) async => Right(file.path!));

      // Act
      final result = await saveFileUC(file);

      // Assert
      expect(result.getRightOrFailTest(), file.path!);
      verify(repository.save(file)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('SaveFile UC (Fail)', () async {
      // Arrange
      when(repository.save(file)).thenAnswer((_) async => Left(CacheFailure()));

      // Act
      final result = await saveFileUC(file);

      // Assert
      expect(result.getLeftOrFailTest(), CacheFailure());
      verify(repository.save(file)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });

  group('SavePdf UC', () {
    test('SavePdf UC (Ok)', () async {
      // Arrange
      when(repository.savePdf(pdfParams))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await savePdfUC(pdfParams);

      // Assert
      expect(result, const Right(null));
      verify(repository.savePdf(pdfParams)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('SavePdf UC (Fail)', () async {
      // Arrange
      when(repository.savePdf(pdfParams))
          .thenAnswer((_) async => Left(CacheFailure()));

      // Act
      final result = await savePdfUC(pdfParams);

      // Assert
      expect(result.getLeftOrFailTest(), CacheFailure());
      verify(repository.savePdf(pdfParams)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });

  group('DeleteFile UC', () {
    test('DeleteFile UC (Ok)', () async {
      // Arrange
      when(repository.delete(file.path!)).thenAnswer((_) async => const Right(null));

      // Act
      final result = await deleteFileUC(file.path!);

      // Assert
      expect(result, const Right(null));
      verify(repository.delete(file.path!)).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('DeleteFile UC (Fail)', () async {
      // Arrange
      when(repository.delete(file.path!))
          .thenAnswer((_) async => Left(CacheFailure()));

      // Act
      final result = await deleteFileUC(file.path!);

      // Assert
      expect(result.getLeftOrFailTest(), CacheFailure());
      verify(repository.delete(file.path!)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
