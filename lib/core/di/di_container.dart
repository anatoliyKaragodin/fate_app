import 'package:fate_app/core/database/database_manager.dart';
import 'package:fate_app/features/characters/data/datasources/characters_lds.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/characters_lds_impl.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/file_management/data/datasources/file_lds_intrerface.dart';
import 'package:fate_app/features/file_management/data/repositories/file_repository_impl.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_management/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_management/domain/usecases/copy_file.dart';
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:get_it/get_it.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';

import '../../features/characters/data/datasources/local/sqlite/LDS_constants.dart';
import '../../features/characters/data/repositories/characters_repository_impl.dart';
import '../../features/file_management/data/datasources/local/file_LDS_impl.dart';
import '../../features/file_management/domain/usecases/save_pdf.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final db = await DatabaseManager.initDB(LDSconstants.dbCharacters);

  getIt.registerLazySingleton(() => db);

  // Регистрация источника данных
  getIt.registerLazySingleton<CharactersLDS>(() => CharactersLDSImpl(getIt()));
  getIt.registerLazySingleton<FileLDS>(() => FileLdsImpl());

  // Регистрация репозитория
  getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<FileRepository>(() => FileRepositoryImpl(getIt()));

  // Регистрация use cases

  getIt.registerLazySingleton(() => GetCharacters(getIt()));

  getIt.registerLazySingleton(() => SaveNewCharacter(getIt()));

  getIt.registerLazySingleton(() => UpdateCharacter(getIt()));

  getIt.registerLazySingleton(() => DeleteCharacter(getIt()));

  getIt.registerLazySingleton(() => SavePdf(getIt()));

  getIt.registerLazySingleton(() => CopyFile(getIt()));

  getIt.registerLazySingleton(() => DeleteFile(getIt()));
}
