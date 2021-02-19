import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uebersetzer/core/errors/exceptions.dart';
import 'package:uebersetzer/features/search/data/models/word_model.dart';
import 'package:uebersetzer/core/utils/extensions.dart';

abstract class DatabaseHelper {
  Future<Database> get database;

  Future<Database> _initDatabase();

  Future _onCreate(Database db, int version);

  Future<List<Map<String, dynamic>>> rawQuery(String query);

  Future<int> insert(Map<String, dynamic> row);

  Future<List<Map<String, dynamic>>> queryAllRows();

  Future<int> queryRowCount();

  Future<int> update(Map<String, dynamic> row);

  Future<int> delete(int id);

  Future<List<Map<String, dynamic>>> performSearchQuery(String target);

  /// --- Favorites ---

  Future<int> addFavorite(WordModel word);

  Future<List<Map<String, dynamic>>> getFavorites();

  Future<int> removeFavorite(int id);

  /// ----------------
}

class DatabaseHelperImpl implements DatabaseHelper {
  static final _databaseName = "dictionary.db";
  static final _databaseVersion = 1;

  /// Local Dictionary Table
  static const localDictionaryTable = 'local_dictionary';
  static const localDictionaryColumnId = '_id';
  static const localDictionaryColumnWord = 'word';
  static const localDictionaryColumnPlural = 'plural';
  static const localDictionaryColumnGender = 'gender';
  static const localDictionaryColumnMeaning = 'meaning';

  /// Favorites Table
  static const favoritesTable = 'favorites';
  static const favoritesColumnId = 'id';
  static const favoritesColumnWordId = 'word_id';
  static const favoritesColumnWord = 'word';

  // make this a singleton class
  DatabaseHelperImpl._privateConstructor();

  static final DatabaseHelperImpl instance =
      DatabaseHelperImpl._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  @override
  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      try {
        // Copy from asset
        ByteData data =
            await rootBundle.load(join("assets", "databases", "dictionary.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (_) {
        throw NoLocalDictionaryException();
      }
    } else {}
    // open the database
    return openDatabase(path, readOnly: false, onCreate: _onCreate, version: 4);
  }

  // SQL code to create the database table
  @override
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $favoritesTable (
            $favoritesColumnId INTEGER PRIMARY KEY,
            $favoritesColumnWordId TEXT UNIQUE NOT NULL,
            $favoritesColumnWord TEXT NOT NULL
          )
          ''');
  }

  // Helper methods
  @override
  Future<List<Map<String, dynamic>>> rawQuery(String query) async {
    Database db = await instance.database;
    return await db.rawQuery(query);
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  @override
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(localDictionaryTable, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  @override
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(localDictionaryTable);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  @override
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $localDictionaryTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  @override
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[localDictionaryColumnId];
    return await db.update(localDictionaryTable, row,
        where: '$localDictionaryColumnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  @override
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(localDictionaryTable,
        where: '$localDictionaryColumnId = ?', whereArgs: [id]);
  }

  @override
  Future<List<Map<String, dynamic>>> performSearchQuery(String target) async {
    return rawQuery(
      'SELECT $localDictionaryTable.*, $favoritesTable.$favoritesColumnId as fav_id, $localDictionaryTable.$localDictionaryColumnWord || $localDictionaryTable.$localDictionaryColumnGender as mWordId FROM $localDictionaryTable LEFT JOIN $favoritesTable ON $favoritesTable.`$favoritesColumnWordId` = mWordId WHERE $localDictionaryTable.`word` like \'%${target.replaceAll(' ', '%')}\';',
    );
  }

  @override
  Future<int> addFavorite(WordModel word) async {
    Database db = await instance.database;
    var wordMap = word.toMap();
    wordMap['plural'] = jsonEncode([wordMap['plural']]);
    print(wordMap);
    final String wordId = word.word + word.type.toTypeString();
    return await db.insert(favoritesTable, {
      favoritesColumnWordId: wordId,
      favoritesColumnWord: jsonEncode(wordMap)
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getFavorites() async {
    return await rawQuery(
      'SELECT * FROM $favoritesTable;',
    );
  }

  @override
  Future<int> removeFavorite(int id) async {
    Database db = await instance.database;
    return await db.delete(favoritesTable,
        where: '$favoritesColumnId = ?', whereArgs: [id]);
  }
}
