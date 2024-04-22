import 'package:fate_app/data/datasources/characters_datasource_interface.dart';
import 'package:fate_app/data/mapper/models_mapper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CharactersLocalDataSourceSQLiteImpl
    implements CharactersDataSourceInterface {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'characters_database.db'),

      
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE characters(id INTEGER PRIMARY KEY, name TEXT, description TEXT, image TEXT, remote_id TEXT, locale_id NUMBER)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('characters');

    return List.generate(maps.length, (i) {
      return CharacterModelMapper.fromMap(maps[i]);
    });
  }

  @override
  Future<void> insertCharacter(CharacterModel character) async {
    final db = await database;
    await db.insert(
      'characters',
      character.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateCharacter(CharacterModel character) async {
    final db = await database;
    await db.update(
      'characters',
      character.toMap(),
      where: "id = ?",
      whereArgs: [character.localeId],
    );
  }
}
