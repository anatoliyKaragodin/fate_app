import 'package:dartz/dartz.dart';
import 'package:fate_app/core/error/failure.dart';
import 'package:fate_app/features/characters/domain/mapper/entities_mapper.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_new_character_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CharactersRepository>()])
void main() {
  late SaveNewCharacter saveNewCharacterUC;
  late MockCharactersRepository charactersRepository;

  final character = CharacterEntity.empty();

  setUp(() {
    charactersRepository = MockCharactersRepository();
    saveNewCharacterUC = SaveNewCharacter(charactersRepository);
  });

  group('SaveNewCharacterUC', () {
    test('SaveNewCharacterUC (Ok)', () async {
      // Arrange
      when(charactersRepository.saveNew(character))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      // Act
      final result = await saveNewCharacterUC(character);

      // Assert
      expect(result, const Right<Failure, void>(null));
      verify(charactersRepository.saveNew(character)).called(1);
      verifyNoMoreInteractions(charactersRepository);
    });

    test('SaveNewCharacterUC (Fail)', () async {
      // Arrange
      when(charactersRepository.saveNew(character))
          .thenAnswer((_) async => Left<Failure, void>(CacheFailure()));

      // Act
      final result = await saveNewCharacterUC(character);

      // Assert
      expect(result, Left<Failure, void>(CacheFailure()));
      verify(charactersRepository.saveNew(character)).called(1);
      verifyNoMoreInteractions(charactersRepository);
    });
  });
}
