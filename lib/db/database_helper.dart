import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'education1.db';
  static final _dbVersion = 2;
  // user Table
  static final _userTableName = 'user';
  static final _columnId = 'user_id';
  static final _columnName = 'name';
  static final _columnUserName = 'user_name';
  static final _columnPassword = 'password';
// lessons Table
  static final _lessonsTableName = 'lessons';
  static final _lessonsColumnId = 'lesson_id';
  static final _lessonsColumnTitle = 'lesson_title';
  static final _lessonsColumnName = 'lesson';
  static final _lessonsColumnGrade = 'grade';
  static final _lessonsColumnAddedUser = 'added_user';

  // movies Table
  static final _moviesTableName = 'movies';
  static final _moviesColumnId = 'movie_id';
  static final _moviesColumnTitle = 'movie_title';
  static final _moviesColumnName = 'movie';
  static final _moviesColumnTypes = 'types';
  static final _moviesColumnAddedUser = 'added_user';

  // musics Table
  static final _musicsTableName = 'musics';
  static final _musicsColumnId = 'music_id';
  static final _musicsColumnTitle = 'music_title';
  static final _musicsColumnName = 'music';
  static final _musicsColumnType = 'type';
  static final _musicsColumnAddedUser = 'added_user';



  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
   await db.execute('''
      CREATE TABLE $_userTableName(
        $_columnId INTEGER PRIMARY KEY,
        $_columnName TEXT NOT NULL,
        $_columnUserName TEXT NOT NULL,
        $_columnPassword TEXT NOT NULL
      )
      ''');
   await db.execute('''
      CREATE TABLE $_lessonsTableName(
        $_lessonsColumnId INTEGER PRIMARY KEY,
        $_lessonsColumnName TEXT NOT NULL,
        $_lessonsColumnTitle TEXT NOT NULL,
        $_lessonsColumnGrade INTEGER NOT NULL,
        $_lessonsColumnAddedUser INTEGER NOT NULL 
      )
      ''');

   await db.execute('''
      CREATE TABLE $_moviesTableName(
        $_moviesColumnId INTEGER PRIMARY KEY,
        $_moviesColumnName TEXT NOT NULL,
        $_moviesColumnTitle TEXT NOT NULL,
        $_moviesColumnTypes INTEGER NOT NULL,
        $_moviesColumnAddedUser INTEGER NOT NULL 
      )
      ''');

   await db.execute('''
      CREATE TABLE $_musicsTableName(
        $_musicsColumnId INTEGER PRIMARY KEY,
        $_musicsColumnName TEXT NOT NULL,
        $_musicsColumnTitle TEXT NOT NULL,
        $_musicsColumnType INTEGER NOT NULL,
        $_musicsColumnAddedUser INTEGER NOT NULL 
      )
      ''');
  }
// user table functions
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_userTableName, row);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
    await db.query(_userTableName, columns: [_columnId, _columnName, _columnUserName,_columnPassword]);
    return maps;
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_columnId];
    return await db
        .update(_userTableName, row, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    db.delete(_userTableName, where: '$_columnId = ?', whereArgs: [id]);
  }


  // lesson table
  Future<int> insertLesson(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // await db.execute("DROP TABLE IF EXISTS tableName");
    //
    return await db.insert(_lessonsTableName, row);
  }

  Future<List<Map<String, dynamic>>> getAllLessons() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
    await db.query(_lessonsTableName, columns: [_lessonsColumnId,
      _lessonsColumnTitle,
      _lessonsColumnName,
      _lessonsColumnGrade,
      _lessonsColumnAddedUser]);
    return maps;
  }

  Future<int> updateLesson(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_lessonsColumnId];
    return await db
        .update(_lessonsTableName, row, where: '$_lessonsColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteLesson(int id) async {
    Database db = await instance.database;
    db.delete(_lessonsTableName, where: '$_lessonsColumnId = ?', whereArgs: [id]);
  }

  // movie table
  Future<int> insertMovie(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // await db.execute("DROP TABLE IF EXISTS tableName");
    //
    return await db.insert(_moviesTableName, row);
  }

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
    await db.query(_moviesTableName, columns: [_moviesColumnId,
      _moviesColumnTitle,
      _moviesColumnName,
      _moviesColumnTypes,
      _moviesColumnAddedUser]);
    return maps;
  }

  Future<int> updateMovie(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_moviesColumnId];
    return await db
        .update(_moviesTableName, row, where: '$_moviesColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteMovie(int id) async {
    Database db = await instance.database;
    db.delete(_moviesTableName, where: '$_moviesColumnId = ?', whereArgs: [id]);
  }


  // music table
  Future<int> insertMusic(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // await db.execute("DROP TABLE IF EXISTS tableName");
    //
    return await db.insert(_musicsTableName, row);
  }

  Future<List<Map<String, dynamic>>> getAllMusics() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
    await db.query(_musicsTableName, columns: [_musicsColumnId,
      _musicsColumnTitle,
      _musicsColumnName,
      _musicsColumnType,
      _musicsColumnAddedUser]);
    return maps;
  }

  Future<int> updateMusic(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_musicsColumnId];
    return await db
        .update(_musicsTableName, row, where: '$_musicsColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteMusic(int id) async {
    Database db = await instance.database;
    db.delete(_musicsTableName, where: '$_musicsColumnId = ?', whereArgs: [id]);
  }








}
 