import 'package:fate_app/core/database/database_manager.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/LDS_constants.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/characters_lds_impl.dart';
import 'package:fate_app/features/characters/data/mapper/models_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late CharactersLDSImpl localDataSourceImpl;
  late Database database;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    database = await DatabaseManager.initDB('test_characters.db');
    localDataSourceImpl = CharactersLDSImpl(database);
  });

  tearDown(() async {
    await database.execute('DELETE FROM ${LDSconstants.tableCharacters}');
  });

  tearDownAll(() async {
    await database.close();
  });

  group('CharactersLDSImpl', () {
    final character1 = CharacterModel.empty(1);
    final character2 = CharacterModel.empty(2);

    final loadingChar1 = character1.copyWith(localeId: 1);
    final loadingChar2 = character2.copyWith(localeId: 2);

    test('CharactersLDSImpl insert', () async {
      // Act
      await localDataSourceImpl.insert(character1);
      await localDataSourceImpl.insert(character2);

      final result = await localDataSourceImpl.getAll();

      // Assert
      expect(result, [loadingChar1, loadingChar2]);
    });

    test('CharactersLDSImpl delete', () async {
      // Act
      await localDataSourceImpl.insert(character1);
      await localDataSourceImpl.insert(character2);

      List<CharacterModel> result = await localDataSourceImpl.getAll();

      for (final char in result) {
        await localDataSourceImpl.delete(char.localeId!);
      }

      result = await localDataSourceImpl.getAll();

      // Assert
      expect(result, []);
    });

    test('CharactersLDSImpl update', () async {
      // Act
      await localDataSourceImpl.insert(character1);

      List<CharacterModel> result = await localDataSourceImpl.getAll();

      final updatedChar = character2.copyWith(localeId: result.first.localeId);

      await localDataSourceImpl.update(updatedChar);

      result = await localDataSourceImpl.getAll();

      // Assert
      expect(result, [updatedChar]);
    });

    test('CharactersLDSImpl getAll', () async {
      // Act
      await localDataSourceImpl.insert(character1);
      await localDataSourceImpl.insert(character2);

      List<CharacterModel> result = await localDataSourceImpl.getAll();

      // Assert
      expect(result,
          [character1.copyWith(localeId: 1), character2.copyWith(localeId: 2)]);
    });
  });
}
