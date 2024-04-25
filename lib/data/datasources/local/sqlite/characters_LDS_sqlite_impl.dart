import 'package:fate_app/data/datasources/characters_datasource_interface.dart';
import 'package:fate_app/data/datasources/local/sqlite/LDS_constants.dart';
import 'package:fate_app/data/mapper/models_mapper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CharactersLDSSQLiteImpl implements CharactersDataSourceInterface {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), LDSconstants.dbCharacters),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE ${LDSconstants.tableCharacters}
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
          )'''
        );
      },
      version: 1,
    );
  }

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(LDSconstants.tableCharacters);

    return List.generate(maps.length, (i) {
      return CharacterModel.fromSQLite(maps[i]);
    });
  }

  @override
  Future<void> insertCharacter(CharacterModel character) async {
    final db = await database;

    await db.insert(
      LDSconstants.tableCharacters,
      character.toSQLite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateCharacter(CharacterModel character) async {
    final db = await database;

    await db.update(
      LDSconstants.tableCharacters,
      character.toSQLite(),
      where: "id = ?",
      whereArgs: [character.localeId],
    );
  }
}
