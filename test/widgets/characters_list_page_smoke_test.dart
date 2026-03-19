import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page.dart';
import 'package:fate_app/features/characters/presentation/pages/characters_list_page/characters_list_page_view_model.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/file_management/domain/usecases/delete_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/characters/domain/entities/mapper/entities_mapper.dart';
import 'package:fate_app/features/file_management/domain/usecases/save_pdf.dart';

class _FakeCharactersRepository implements CharactersRepository {
  @override
  Future<Either<Failure, List<CharacterEntity>>> getAll() async =>
      const Right([]);

  @override
  Future<Either<Failure, void>> deleteCharacter(int id) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> saveNew(CharacterEntity character) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> update(CharacterEntity character) async =>
      const Right(null);
}

class _FakeFileRepository implements FileRepository {
  @override
  Future<Either<Failure, String>> copy(String filePath) async =>
      Right(filePath);

  @override
  Future<Either<Failure, void>> delete(String path) async => const Right(null);

  @override
  Future<Either<Failure, void>> savePdf(PdfParams params) async =>
      const Right(null);
}

void main() {
  testWidgets('CharactersListPage renders', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    final charactersRepo = _FakeCharactersRepository();
    final fileRepo = _FakeFileRepository();

    final vm = CharactersListPageViewModel(
      GetCharacters(charactersRepo),
      DeleteCharacter(charactersRepo),
      DeleteFile(fileRepo),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          charactersListPageViewProvider.overrideWith((ref) => vm),
        ],
        child: const MaterialApp(
          home: CharactersListPage(),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('FAE'), findsOneWidget);

    await tester.binding.setSurfaceSize(null);
  });
}
