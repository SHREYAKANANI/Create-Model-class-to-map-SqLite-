import'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/note.dart';

class DatabaseHelper {
 static DatabaseHelper _databaseHelper;               //Singleton databasehelper
 static Database _database;              //singleton database

 String noteTable = 'note_table';
 String colid = 'id';
 String colTitle = 'title';
 String colDescription = 'description';
 String colpriority = 'priority';
 String colDate = 'Date';
DatabaseHelper._createInstance();   //named constructor to create instance of DatabaseHelper
factory DatabaseHelper() {
  if (_databaseHelper == null) {
    _databaseHelper = DatabaseHelper
        ._createInstance(); //this is executed only once, singleton object
  }
  return _databaseHelper;
}
Future<Database> get database async{
  if (_database == null) {
    _database = await initializeDatabase();
  }
  return _database;
}

Future<Database>initializeDatabase () async {

  //Get the directory path for both Android and iOS to store database.
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path + 'notes.db';
  // Open/create the database at a given path
  var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
  return notesDatabase;

}
void _createDb(Database db, int newVersion) async {
  await db.execute('CREATE TABLE $noteTable ($colid INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,'
  '$colDescription TEXT, $colpriority INTEGER, $colDate TEXT)');

}

// Fetch Operation: Get all note objects from database

Future<List<Map<String, dynamic>>> getNoteMapList() async {
  Database db = await this.database;
  //var result = await db.rawQuery('SELECT * FROM $noteTable order by $colpriority ASC');
  var result = await db.query(noteTable, orderBy: '$colpriority ASC');
  return result;
}
//Insert Operation: Insert a Note object to database
Future<int> insertNote(Note note) async{
  Database db = await this.database;
  var result = await db.insert(noteTable, note.toMap());
}
//Update Operation: Update a Note object and save it to database
Future<int> updateNote (Note note) async {
  var db = await this.database;
  var result = await db.update(noteTable, note.toMap(), where: '$colid = ?', whereArgs: [note.id]);
  return result;
}
//Delete Operation: Delete a Note object from database
Future<int> deleteNote(int id) async{
  var db = await this.database;
  int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colid = $id');
  return result;
}
//get number of note objects in database
Future<int> getCount() async{
  Database db = await this.database;
  List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
}
}