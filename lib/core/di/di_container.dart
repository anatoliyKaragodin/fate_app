import 'package:dio/dio.dart';
import 'package:fate_app/core/database/database_manager.dart';
import 'package:fate_app/features/character_ai/data/datasources/openai_compatible_chat_datasource.dart';
import 'package:fate_app/features/character_ai/data/repositories/ai_settings_repository_impl.dart';
import 'package:fate_app/features/character_ai/data/repositories/character_ai_generation_repository_impl.dart';
import 'package:fate_app/features/character_ai/domain/repositories/ai_settings_repository.dart';
import 'package:fate_app/features/character_ai/domain/repositories/character_ai_generation_repository.dart';
import 'package:fate_app/features/character_ai/domain/usecases/generate_character_draft.dart';
import 'package:fate_app/features/character_ai/domain/usecases/regenerate_character_field.dart';
import 'package:fate_app/features/characters/data/datasources/characters_lds.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/characters_lds_impl.dart';
import 'package:fate_app/features/characters/domain/repositories/characters_repository.dart';
import 'package:fate_app/features/characters/domain/usecases/delete_character.dart';
import 'package:fate_app/features/file_management/data/datasources/file_lds_interface.dart';
import 'package:fate_app/features/file_management/data/repositories/file_repository_impl.dart';
import 'package:fate_app/features/file_management/domain/repositories/file_repository.dart';
import 'package:fate_app/features/file_management/domain/usecases/delete_file.dart';
import 'package:fate_app/features/file_management/domain/usecases/copy_file.dart';
import 'package:fate_app/features/characters/domain/usecases/save_new_character.dart';
import 'package:get_it/get_it.dart';
import 'package:fate_app/features/characters/domain/usecases/get_characters.dart';
import 'package:fate_app/features/characters/domain/usecases/update_character.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/characters/data/datasources/local/sqlite/LDS_constants.dart';
import '../../features/characters/data/repositories/characters_repository_impl.dart';
import '../../features/file_management/data/datasources/local/file_LDS_impl.dart';
import '../../features/file_management/domain/usecases/save_pdf.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final db = await DatabaseManager.initDB(LDSconstants.dbCharacters);
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton(() => db);
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 120),
        // Иначе часто идёт Dart/… — у части CDN/WAF это 403, тогда как curl/Postman ок.
        headers: const {
          'User-Agent': 'FateApp/1.0 (Flutter; OpenAI-compatible LLM client)',
        },
      )));
  getIt.registerLazySingleton<OpenAiCompatibleChatDataSource>(
      () => OpenAiCompatibleChatDataSource(getIt()));
  getIt.registerLazySingleton<AiSettingsRepository>(
      () => AiSettingsRepositoryImpl(getIt()));
  getIt.registerLazySingleton<CharacterAiGenerationRepository>(
      () => CharacterAiGenerationRepositoryImpl(getIt()));
  getIt.registerLazySingleton(
      () => GenerateCharacterDraft(getIt(), getIt()));
  getIt.registerLazySingleton(
      () => RegenerateCharacterField(getIt(), getIt()));

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
