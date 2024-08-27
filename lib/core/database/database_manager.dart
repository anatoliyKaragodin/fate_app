import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/characters/data/datasources/local/sqlite/LDS_constants.dart';

class DatabaseManager {
  DatabaseManager._();

  static Future<Database> initDB(String dbLabel) async {
    return await openDatabase(
      join(await getDatabasesPath(), dbLabel),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE ${LDSconstants.tableCharacters}

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
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
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

          // Заполняем новые колонки для всех существующих персонажей
          await db.execute('''
           UPDATE ${LDSconstants.tableCharacters}
           SET ${LDSconstants.columnCreatedAt} = '${DateTime.now().toIso8601String()}',
               ${LDSconstants.columnUpdatedAt} = '${DateTime.now().toIso8601String()}',
               ${LDSconstants.columnStress} = 0,
               ${LDSconstants.columnFateTokens} = 3
          ''');
        }
      },
      version: 2,
    );
  }
}
