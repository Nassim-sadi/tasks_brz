import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:tasks_brz/models/noteModel.dart';

class DatabaseHelper {
  //Data types
  static const idType = 'INTEGER PRIMARY KEY';
  static const boolType = 'BOOLEAN NOT NULL DEFAULT 0';
  static const contentType = 'TEXT NOT NULL';
  static const timeType = 'TEXT NOT NULL';
  static const colorType = 'INTEGER NOT NULL DEFAULT 0';

  // model param
  static const noteId = NoteFields.id;
  static const noteContent = NoteFields.content;
  static const noteBool = NoteFields.isImportant;
  static const noteCreatedOn = NoteFields.createdOn;
  static const noteColor1 = NoteFields.color1;
  static const noteColor2 = NoteFields.color2;

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('notes.db');
    return _database!;
  }

  _initDb(String filePath) async {
    final dbFilePath = await getDatabasesPath();
    final path = join(dbFilePath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  _createDb(Database db, int version) async {
    await db.execute(''' 
        CREATE TABLE $notesTable (
          ${NoteFields.id} $idType,
          ${NoteFields.isImportant} $boolType,
          ${NoteFields.content} $contentType,
          ${NoteFields.createdOn} $timeType,
          ${NoteFields.color1} $colorType,
          ${NoteFields.color2} $colorType
          
        )
      ''');
  }

  Future<int> create(NoteModel note) async {
    final db = await instance.database;
    final id = await db.insert(notesTable, note.toMap());
    return id;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(notesTable, row);
  }

  Future<List<NoteModel>> queryAll() async {
    Database db = await instance.database;
    var notes = await db.query(notesTable, orderBy: '$noteBool DESC ,$noteCreatedOn ASC');
    List<NoteModel> noteslist =
        notes.isNotEmpty ? notes.map((e) => NoteModel.fromMap(e)).toList() : [];
    return noteslist;
  }

  Future<List<NoteModel>> queryAllFavorites() async {
    Database db = await instance.database;
    var notes = await db.query(notesTable, where: '$noteBool = ?', whereArgs: [1]);
    List<NoteModel> noteslist =
        notes.isNotEmpty ? notes.map((e) => NoteModel.fromMap(e)).toList() : [];
    return noteslist;
  }

  Future<List<NoteModel>> queryAllNonFavorites() async {
    Database db = await instance.database;
    var notes = await db.query(notesTable, where: '$noteBool = ?', whereArgs: [0]);
    List<NoteModel> noteslist =
        notes.isNotEmpty ? notes.map((e) => NoteModel.fromMap(e)).toList() : [];
    return noteslist;
  }

  Future update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[noteId];
    return await db.update(notesTable, row,
        // where: '$noteId = ? $noteContent = ? $noteBool = ? $noteContent = ?', whereArgs: [
        where: '$noteId = ?',
        whereArgs: [id]);
  }

  Future delete(int id) async {
    Database db = await instance.database;

    return await db.delete(notesTable, where: '$noteId = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
