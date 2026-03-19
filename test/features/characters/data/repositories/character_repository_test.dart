import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/exception.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/characters/data/datasources/characters_lds.dart';
import 'package:fate_app/features/characters/data/mapper/models_mapper.dart';
import 'package:fate_app/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_repository_test.mocks.dart';
import '../../../../test_utils/either_test_x.dart';

@GenerateNiceMocks([MockSpec<CharactersLDS>()])
void main() {
  late CharactersRepository charactersRepository;
  late MockCharactersLDS mockCharactersLDS;

  final characterModel = CharacterModel.empty(1);

  final characterEntity = characterModel.toEntity();
  final loadingCharacterList = [
    characterModel.copyWith(localeId: 1, remoteId: '4234324', image: 'image')
  ];

  setUp(() {
    mockCharactersLDS = MockCharactersLDS();
    charactersRepository = CharactersRepositoryImpl(mockCharactersLDS);
  });

  group('CharactersRepository saveNew', () {
    test('CharactersRepository saveNew (Ok)', () async {
      // Arrange
      when(mockCharactersLDS.insert(characterModel)).thenAnswer((_) async {});

      // Act
      final res = await charactersRepository.saveNew(characterEntity);

      // Assert
      expect(res, const Right(null));
      verify(mockCharactersLDS.insert(characterModel)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });

    test('CharactersRepository saveNew (Fail)', () async {
      // Arrange
      when(mockCharactersLDS.insert(characterModel))
          .thenThrow(CacheException());

      // Act
      final res = await charactersRepository.saveNew(characterEntity);

      // Assert
      expect(res, Left(CacheFailure()));
      verify(mockCharactersLDS.insert(characterModel)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });
  });

  group('CharactersRepository getAll', () {
    test('CharactersRepository getAll (Ok)', () async {
      // Arrange
      when(mockCharactersLDS.getAll())
          .thenAnswer((_) async => loadingCharacterList);

      // Act
      final res = await charactersRepository.getAll();

      // Assert

      expect(res.getRightOrFailTest(),
          equals(loadingCharacterList.map((e) => e.toEntity()).toList()));
      verify(mockCharactersLDS.getAll()).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });

    test('CharactersRepository getAll (Fail)', () async {
      // Arrange
      when(mockCharactersLDS.getAll()).thenThrow(CacheException());

      // Act
      final res = await charactersRepository.getAll();

      // Assert
      expect(res, Left(CacheFailure()));
      verify(mockCharactersLDS.getAll()).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });
  });

  group('CharactersRepository update', () {
    test('CharactersRepository update (Ok)', () async {
      // Arrange
      when(mockCharactersLDS.update(characterModel)).thenAnswer((_) async {});

      // Act
      final res = await charactersRepository.update(characterEntity);

      // Assert
      expect(res, const Right(null));
      verify(mockCharactersLDS.update(characterModel)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });

    test('CharactersRepository update (Fail)', () async {
      // Arrange
      when(mockCharactersLDS.update(characterModel))
          .thenThrow(CacheException());

      // Act
      final res = await charactersRepository.update(characterEntity);

      // Assert
      expect(res, Left(CacheFailure()));
      verify(mockCharactersLDS.update(characterModel)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });
  });

  group('CharactersRepository deleteCharacter', () {
    test('CharactersRepository deleteCharacter (Ok)', () async {
      // Arrange
      when(mockCharactersLDS.delete(any)).thenAnswer((_) async {});

      // Act
      final res = await charactersRepository.deleteCharacter(1);

      // Assert
      expect(res, const Right(null));
      verify(mockCharactersLDS.delete(1)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });

    test('CharactersRepository deleteCharacter (Fail)', () async {
      // Arrange
      when(mockCharactersLDS.delete(any)).thenThrow(CacheException());

      // Act
      final res = await charactersRepository.deleteCharacter(1);

      // Assert
      expect(res, Left(CacheFailure()));
      verify(mockCharactersLDS.delete(1)).called(1);
      verifyNoMoreInteractions(mockCharactersLDS);
    });
  });
}
