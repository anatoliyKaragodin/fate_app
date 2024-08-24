import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/characters/data/datasources/local/sqlite/LDS_constants.dart';

class DatabaseManager {
  DatabaseManager._();
  // static final DatabaseManager instance = DatabaseManager._internal();
  // Database? _database;

  // factory DatabaseManager() {
  //   return instance;
  // }

  // DatabaseManager._internal();

  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //   _database = await _initDB();
  //   return _database!;
  // }

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
      version: 1,
    );
  }
}
