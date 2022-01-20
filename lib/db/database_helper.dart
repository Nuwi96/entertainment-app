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
}
 