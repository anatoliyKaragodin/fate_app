import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:fate_app/core/error/exeption.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/file_managment/data/datasources/file_lds_intrerface.dart';
import 'package:fate_app/features/file_managment/data/repositories/file_repository_impl.dart';
import 'package:fate_app/features/file_managment/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pdf/widgets.dart';

import 'file_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FileLDS>()])
void main() {
  late FileLDS lds;
  late FileRepository repository;

  final PlatformFile file = PlatformFile(
    name: 'test_file.txt',
    path: '/path/to/test_file.txt',
    bytes: Uint8List(0),
    size: 0,
  );

  final pdfParams = PdfParams(pdf: Document(), name: 'pdf name');

  setUp(() {
    lds = MockFileLDS();
    repository = FileRepositoryImpl(lds);
  });

  group('FileRepository save', () {
    test('FileRepository save (Ok)', () async {
      // Arrange
      when(lds.save(file)).thenAnswer((_) async => file.path);

      // Act
      final res = await repository.save(file);

      // Assert
      expect(res.getRightOrFailTest(), file.path);
      verify(lds.save(file)).called(1);
      verifyNoMoreInteractions(lds);
    });

    test('FileRepository save (Fail)', () async {
      // Arrange
      when(lds.save(file)).thenThrow(CacheException());

      // Act
      final res = await repository.save(file);

      // Assert
      expect(res.getLeftOrFailTest(), CacheFailure());
      verify(lds.save(file)).called(1);
      verifyNoMoreInteractions(lds);
    });
  });

  group('FileRepository savePdf', () {
    test('FileRepository savePdf (Ok)', () async {
      // Arrange
      when(lds.savePdf(pdfParams)).thenAnswer((_) async {});

      // Act
      final res = await repository.savePdf(pdfParams);

      // Assert
      expect(res, const Right(null));
      verify(lds.savePdf(pdfParams)).called(1);
      verifyNoMoreInteractions(lds);
    });

    test('FileRepository savePdf (Fail)', () async {
      // Arrange
      when(lds.savePdf(pdfParams)).thenThrow(CacheException());

      // Act
      final res = await repository.savePdf(pdfParams);

      // Assert
      expect(res.getLeftOrFailTest(), CacheFailure());
      verify(lds.savePdf(pdfParams)).called(1);
      verifyNoMoreInteractions(lds);
    });
  });

  group('FileRepository delete', () {
    test('FileRepository delete (Ok)', () async {
      // Arrange
      when(lds.delete(file.path!)).thenAnswer((_) async {});

      // Act
      final res = await repository.delete(file.path!);

      // Assert
      expect(res, const Right(null));
      verify(lds.delete(file.path!)).called(1);
      verifyNoMoreInteractions(lds);
    });

    test('FileRepository delete (Fail)', () async {
      // Arrange
      when(lds.delete(file.path!)).thenThrow(CacheException());

      // Act
      final res = await repository.delete(file.path!);

      // Assert
      expect(res.getLeftOrFailTest(), CacheFailure());
      verify(lds.delete(file.path!)).called(1);
      verifyNoMoreInteractions(lds);
    });
  });
}
