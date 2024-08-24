import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'characters_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CharactersRepository>()])
void main() {
  late SaveNewCharacter saveNewCharacterUC;
  late DeleteCharacter deleteCharacterUC;
  late UpdateCharacter updateCharacterUC;
  late GetCharacters getCharactersUC;

  late MockCharactersRepository mockCharactersRepository;

  final character = CharacterEntity.empty();

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();

    saveNewCharacterUC = SaveNewCharacter(mockCharactersRepository);
    deleteCharacterUC = DeleteCharacter(mockCharactersRepository);
    updateCharacterUC = UpdateCharacter(mockCharactersRepository);
    getCharactersUC = GetCharacters(mockCharactersRepository);
  });

  group('SaveNewCharacterUC', () {
    test('SaveNewCharacterUC (Ok)', () async {
      // Arrange
      when(mockCharactersRepository.saveNew(character))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      // Act
      final result = await saveNewCharacterUC(character);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(mockCharactersRepository.saveNew(character)).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('SaveNewCharacterUC (Fail)', () async {
      // Arrange
      when(mockCharactersRepository.saveNew(character))
          .thenAnswer((_) async => Left<Failure, void>(CacheFailure()));

      // Act
      final result = await saveNewCharacterUC(character);

      // Assert
      expect(result, Left<Failure, void>(CacheFailure()));
      verify(mockCharactersRepository.saveNew(character)).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });

  group('DeleteCharacterUC', () {
    test('DeleteCharacterUC (Ok)', () async {
      // Arrange
      when(mockCharactersRepository.deleteCharacter(1))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      // Act
      final result = await deleteCharacterUC(1);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(mockCharactersRepository.deleteCharacter(1)).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('DeleteCharacterUC (Fail)', () async {
      // Arrange
      when(mockCharactersRepository.deleteCharacter(1))
          .thenAnswer((_) async => Left<Failure, void>(CacheFailure()));

      // Act
      final result = await deleteCharacterUC(1);

      // Assert
      expect(result, Left<Failure, void>(CacheFailure()));
      verify(mockCharactersRepository.deleteCharacter(1)).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });

  group('UpdateCharacterUC', () {
    test('UpdateCharacterUC (Ok)', () async {
      // Arrange
      when(mockCharactersRepository.update(character.copyWith(localeId: 1)))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      // Act
      final result = await updateCharacterUC(character.copyWith(localeId: 1));

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(mockCharactersRepository.update(character.copyWith(localeId: 1))).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('UpdateCharacterUC (Fail)', () async {
      // Arrange
      when(mockCharactersRepository.update(character.copyWith(localeId: 1)))
          .thenAnswer((_) async => Left<Failure, void>(CacheFailure()));

      // Act
      final result = await updateCharacterUC(character.copyWith(localeId: 1));

      // Assert
      expect(result, Left<Failure, void>(CacheFailure()));
      verify(mockCharactersRepository.update(character.copyWith(localeId: 1))).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });

   group('GetCharactersUC', () {
    test('GetCharactersUC (Ok)', () async {
      // Arrange
      when(mockCharactersRepository.getAll())
          .thenAnswer((_) async => Right([character]));

      // Act
      final result = await getCharactersUC(null);

      // Assert
      expect(result.getRightOrFailTest(), [character]);
      verify(mockCharactersRepository.getAll()).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('GetCharactersUC (Fail)', () async {
      // Arrange
      when(mockCharactersRepository.getAll())
          .thenAnswer((_) async => Left(CacheFailure()));

      // Act
      final result = await getCharactersUC(null);

      // Assert
      expect(result, Left<Failure, void>(CacheFailure()));
      verify(mockCharactersRepository.getAll()).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
