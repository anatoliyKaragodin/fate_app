import 'package:fate_app/features/characters/data/datasources/characters_LDS_interface.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/characters_LDS_impl.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/file_managment/data/datasources/file_DS_intrerface.dart';
import 'package:fate_app/features/file_managment/data/datasources/local/file_LDS_impl.dart';
import 'package:fate_app/features/file_managment/data/repositories/file_repository_impl.dart';
import 'package:fate_app/features/file_managment/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_managment/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_managment/domain/usecases/save_file.dart';
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:get_it/get_it.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:fate_app/features/characters/data/repositories/characters_repository_impl.dart';

import '../../features/file_managment/domain/usecases/save_pdf.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Регистрация источника данных
  getIt.registerSingleton<CharactersLDSInterface>(CharactersLDSImpl());
  getIt.registerSingleton<FileLDSInterface>(FileLdsImpl());

  final charactersLocalDataSource = getIt.get<CharactersLDSInterface>();
  final fileLDS = getIt.get<FileLDSInterface>();

  // Регистрация репозитория
  getIt.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(charactersLocalDataSource));
  getIt.registerSingleton<FileRepository>(FileRepositoryImpl(fileLDS));

  final charactersRepository = getIt.get<CharactersRepository>();
  final fileRepository = getIt.get<FileRepository>();

  // Регистрация use cases
  getIt.registerSingleton<GetCharacters>(GetCharacters(charactersRepository));

  getIt.registerSingleton<SaveNewCharacter>(
      SaveNewCharacter(charactersRepository));

  getIt.registerSingleton<UpdateCharacter>(
      UpdateCharacter(charactersRepository));

  getIt.registerSingleton<DeleteCharacter>(
      DeleteCharacter(charactersRepository));

  getIt.registerSingleton<SavePdf>(SavePdf(fileRepository));

  getIt.registerSingleton<SaveFile>(SaveFile(fileRepository));

  getIt.registerSingleton<DeleteFile>(DeleteFile(fileRepository));
}
