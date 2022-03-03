// import 'package:sqflite/sqflite.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:notelist/model/note.dart';
// class DatabaseHelper{
// static DatabaseHelper _databaseHelper;
// static Database _database;
// String noteTable ='note_table';
// String colId='id';
// DatabaseHelper._createInstance();
// factory DatabaseHelper(){
//   if (_databaseHelper==null){
//     _databaseHelper=DatabaseHelper._createInstance();
//   }
//   return _databaseHelper;
// }
// Future<Database>get database async{
//   if (_database==null){
//     _database=await initializeDatabase();
//   }
//   return _database;
// }
// Future <Database>initializeDatabase()async{
//   //Get the directory path for vboth Andriod and ios to store database.
//   Directory directory=getApplicationDocumentsDirectory();
// String path=directory.path+'notes.db';
// //open/create the database  at a given
// var notesDatabase=await openDatabase(path,version:1,onCreate:_createDb);
// return notesDatabase;
// }

// void _createDb(Database Db,int newVersion)async{
//   await db.execute('CREATE TABLE$noteTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,''$colDescription TEXT,$colPriorirty INTEGER,$colDate TEXT)');
// }
// //Fetch operation:get all notes objects from database
// Future<List<Map<String,dynamic>>>getNoteMapList()async{
//   Database db=await this.database;
// }
// //insert operation:insert a Note object and Save it to database
// getNoteMapList()async{
//   Database db=await this.database;
//   var result=await db.rawQuery('SELECT*FROM$noteTable order by %colPriorrity ASC');
//   var result=await db.query(noteTable,orderBy:'$colPriority ASC');
// return result;
// }
// //var result=await db.rawQuery('Select*From$noteTable order by ScalePriirity ASC);
// var result=await db.query(noteTable,orderby:'$colpriority ASC');


// //update operation:update a Note object and save it to database
// Future<int>updateNote(Note note)async{
//   var db=await this.database;
//   var result=await db.updte(noteTable,note,toMap(),where:'$colId=?',whereArgs:[note.id]);
//   return result;
// }

// //Delete operation:Delete a Note object from databae
// Future<int>deleteNote(int id)async{
//   var db=await this.database;
//   int result=await db.rawDelete('DELETE From $noteTable WHERE $colId=$id');
//   return result;
// //Get number of Note objects in data base
// Future<int>getCount(int id)async{
//   Database db=await this.database;
//   List<Map<String,dynamic>>x=await db.rawQuery('SELECT COUNT(*) from $noteTable');
//   int result=Sqflite.firstIntValue(x);
//   return result;
// }

// }
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notelist/model/note.dart';
class NotesDatabase{
static final NotesDatabase instance =NotesDatabase._init();
static Database? _database;
NotesDatabase._init();
Future<Database> get database async{
  if(_database!=null)return _database!;
  _database=await _initDB('notes.db');
  return _database!;
}
Future<Database> _initDB(String filePath) async{
  final dbPath=await getDatabasesPath();
  final Path =join(dbPath, filePath);
  return await openDatabase(Path,version: 1,onCreate: _createDB);
}
Future _createDB(Database db,int version) async {
const idType ='INTEGER PRIMARY KEY AUTOINCREMENT';
const boolType='BOOLEAN NOT NULL';
const integerType='INTEGER NOT NULL';
await db.execute('''CREATE TABLE $tableNotes(
  ${NoteFields.id}$idType,
  ${NoteFields.isImportant}$boolType,
  ${NoteFields.number}$integerType,
  ${NoteFields.title}$textType,
  ${NoteFields.description}$textType,
  ${NoteFields.time}$textType,

) ''');
Future<Note> create(Note note) async{
   final db =await instance.database;
   final  id=await db.insert(tableNotes,note.toJson());
   return note.copy(id:id);
}
Future<Note>readNote(int id) async {
  final db =await instance.database;
  final maps =await db.query(tableNotes,columns: NoteFields.values,
  //prevent SQL injection support
  where: '${NoteFields.id}=?',
  whereArgs:[id],);
  if (maps.isNotEmpty){
    return Note.fromJson(maps.first);
  }else {
    throw Exception('ID $id not found');
  }
}
Future<List<Note>> readAllNotes()async {
  final db=await instance.database;
  final result=await db.query(tableNotes);
  return result.map(json)=>Note.fromJson(json).toList();
}
Future <int> update (Note note)
  async {
    final db=await instance .database;
    return db.update(
      tableNotes,note.toJson(),
      where: '${NoteFields.id}=?',
      whereArgs: [note.id],
    );
  }
  Future<int>delete(int id) async{
    final db=await instance.database;
    return await db.delete(tableNotes,
    where: '${NoteFields.id}=?',
    whereArgs: [id],);

  }
  }
Future close() async{
  final db=await instance .database;
  db.close();
}
}