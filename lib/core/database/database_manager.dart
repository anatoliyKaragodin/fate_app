import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as dev;

import '../../features/characters/data/datasources/local/sqlite/LDS_constants.dart';

class DatabaseManager {
  DatabaseManager._();

  static Future<Database> initDB(String dbLabel) async {
    return await openDatabase(
      join(await getDatabasesPath(), dbLabel),
      version: 2, // Устанавливаем начальную версию базы данных на 2
      onCreate: (db, version) async {
        dev.log('Creating database version $version');
        // Создание таблицы версии 1 при первой инициализации базы данных
        await db.execute('''CREATE TABLE ${LDSconstants.tableCharacters}
          (
          id INTEGER PRIMARY KEY, 
          ${LDSconstants.columnName} TEXT, 
          ${LDSconstants.columnDescription} TEXT, 
          ${LDSconstants.columnImage} TEXT, 
          ${LDSconstants.columnConcept} TEXT, 
          ${LDSconstants.columnStunts} TEXT, 
          ${LDSconstants.columnAspects} TEXT, 
          ${LDSconstants.columnProblems} TEXT, 
          ${LDSconstants.columnRemoteId} TEXT, 
          ${LDSconstants.columnLocalId} INTEGER, 
          ${LDSconstants.columnSkills} TEXT
          )''');
        // Выполняем обновление до версии 2 сразу после создания
        await _upgradeToVersion2(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        dev.log('Upgrading database from version $oldVersion to $newVersion');
        if (oldVersion < 2) {
          await _upgradeToVersion2(db);
        }
      },
    );
  }

  static Future<void> _upgradeToVersion2(Database db) async {
    // Добавление новых колонок при обновлении базы данных до версии 2
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnAudio} TEXT
    ''');
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnCreatedAt} TEXT
    ''');
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnUpdatedAt} TEXT
    ''');
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnStress} INTEGER
    ''');
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnConsequences} TEXT
    ''');
    await db.execute('''
      ALTER TABLE ${LDSconstants.tableCharacters} 
      ADD COLUMN ${LDSconstants.columnFateTokens} INTEGER
    ''');

    // Заполнение новых колонок для всех существующих записей
    await db.execute('''
     UPDATE ${LDSconstants.tableCharacters}
     SET ${LDSconstants.columnCreatedAt} = '${DateTime.now().toIso8601String()}',
         ${LDSconstants.columnUpdatedAt} = '${DateTime.now().toIso8601String()}',
         ${LDSconstants.columnStress} = 0,
         ${LDSconstants.columnFateTokens} = 3
    ''');
  }
}