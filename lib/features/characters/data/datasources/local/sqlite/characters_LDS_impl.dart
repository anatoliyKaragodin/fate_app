
import 'package:fate_app/core/error/exeption.dart';
import 'package:fate_app/features/characters/data/datasources/characters_LDS_interface.dart';
import 'package:fate_app/features/characters/data/datasources/local/sqlite/LDS_constants.dart';
import 'package:fate_app/features/characters/data/mapper/models_mapper.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

class CharactersLDSImpl implements CharactersLDSInterface {
  final Database _db;

  CharactersLDSImpl(this._db);

  // Future<Database> get database async {
  //   if (_database != null) return _database!;

  //   _database = await initDB();

  //   return _database!;
  // }

  // initDB() async {
  //   return await openDatabase(
  //     join(await getDatabasesPath(), LDSconstants.dbCharacters),
  //     onCreate: (db, version) {
  //       return db.execute('''CREATE TABLE ${LDSconstants.tableCharacters}
  //         (
  //         id INTEGER PRIMARY KEY, 
  //         ${LDSconstants.columnName} TEXT, 
  //         ${LDSconstants.columnDescription} TEXT, 
  //         ${LDSconstants.columnImage} TEXT, 
  //         ${LDSconstants.columnConcept} TEXT, 
  //         ${LDSconstants.columnStunts} TEXT, 
  //         ${LDSconstants.columnAspects} TEXT, 
  //         ${LDSconstants.columnProblems} TEXT, 
  //         ${LDSconstants.columnRemoteId} TEXT, 
  //         ${LDSconstants.columnLocalId} INTEGER, 
  //         ${LDSconstants.columnSkills} TEXT
  //         )''');
  //     },
  //     version: 1,
  //   );
  // }

  @override
  Future<List<CharacterModel>> getAll() async {

    try {
      final List<Map<String, dynamic>> maps =
          await _db.query(LDSconstants.tableCharacters);

      // dev.log(maps.toString());

      return List.generate(maps.length, (i) {
        return CharacterModel.fromSQLite(maps[i]);
      });
    } catch (e) {
      dev.log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> insert(CharacterModel character) async {

    final res = await _db.insert(
      LDSconstants.tableCharacters,
      character.toSQLite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (res == 0) {
      throw CacheException();
    }
  }

  @override
  Future<void> update(CharacterModel character) async {

    final res = await _db.update(
      LDSconstants.tableCharacters,
      character.toSQLite(),
      where: "id = ?",
      whereArgs: [character.localeId],
    );

    if (res != character.localeId) {
      throw CacheException();
    }
  }

  @override
  Future<void> delete(int id) async {

    final res = await _db.delete(
      LDSconstants.tableCharacters,
      where: "id = ?",
      whereArgs: [id],
    );

    if (res == 0) {
      throw CacheException();
    }
  }
}
