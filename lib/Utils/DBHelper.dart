import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_lotto/Models/NoteModel.dart';

class DBHelper {
  static DBHelper? _dbHelper; //singleton
  static Database? _db;

  DBHelper._createInstance();
  String tableNote = 'NoteTable';
  String col_id = 'id';
  String col_title = 'title';
  String col_detail = 'details';
  String col_priority = 'priority';
  String col_time = 'time';

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db!;
  }

  Future<Database> initDB() async {
    Directory _dir = await getApplicationDocumentsDirectory();
    String strPath = _dir.path + 'notes.db';

    var noteDB = await openDatabase(strPath, version: 1, onCreate: createDB);
    return noteDB;
  }

  void createDB(Database db, int intVersion) async {
    await db.execute(
        'CREATE TABLE $tableNote($col_id INTEGER PRIMARY KEY AUTOINCREMENT, $col_title TEXT,$col_detail TEXT,$col_priority INTEGER,$col_time TEXT)');
  }

  //db functions
  //fetch
  Future<List<Map<String, dynamic>>> getAllList() async {
    Database db = await database;
    var result = db.query(tableNote, orderBy: '$col_priority ASC');
    return result;
  }

  //insert
  Future<int> addNote(NoteModel objNote) async {
    Database db = await database;
    var result = db.insert(tableNote, objNote.toMap());
    return result;
  }

  //update
  Future<int> updateNote(NoteModel objNote) async {
    Database db = await database;
    var result = db.update(tableNote, objNote.toMap(),
        where: '$col_id = ?', whereArgs: [objNote.id]);
    return result;
  }

  //delete
  Future<int> deleteNote(NoteModel objNote) async {
    Database db = await database;
    var result =
        db.delete(tableNote, where: '$col_id = ?', whereArgs: [objNote.id]);
    return result;
  }

  //get count

  Future<int?> getListCount() async {
    Database db = await database;
    List<Map<String, dynamic>> value =
        await db.rawQuery('SELECT COUNT (*) from $tableNote');
    int? cValue = Sqflite.firstIntValue(value);
    return cValue;
  }

  Future<List<NoteModel>> getList() async {
    var arrList = await getAllList();
    List<NoteModel> arrL = [];
    for (int i = 0; i < arrList.length; i++) {
      arrL.add(NoteModel.FromMapToModel((arrList[i])));
    }
    return arrL;
  }
}
