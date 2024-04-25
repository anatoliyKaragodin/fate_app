import 'package:fate_app/data/datasources/characters_datasource_interface.dart';
import 'package:fate_app/data/datasources/local/sqlite/characters_LDS_sqlite_impl.dart';
import 'package:fate_app/domain/repositories/characters_repository.dart';
import 'package:fate_app/domain/usecases/save_new_character.dart';
import 'package:get_it/get_it.dart';
import 'package:fate_app/domain/usecases/get_characters.dart';
import 'package:fate_app/domain/usecases/update_character.dart';
import 'package:fate_app/data/repositories/characters_repository_impl.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Регистрация источника данных
  getIt.registerSingleton<CharactersDataSourceInterface>(
      CharactersLDSSQLiteImpl());

  final charactersLocalDataSource = getIt.get<CharactersDataSourceInterface>();

  // Регистрация репозитория
  getIt.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(charactersLocalDataSource));

  final charactersRepository = getIt.get<CharactersRepository>();

  // Регистрация use cases
  getIt.registerSingleton<GetCharacters>(GetCharacters(charactersRepository));

  getIt.registerSingleton<SaveNewCharacter>(
      SaveNewCharacter(charactersRepository));

  getIt.registerSingleton<UpdateCharacter>(
      UpdateCharacter(charactersRepository));
}
