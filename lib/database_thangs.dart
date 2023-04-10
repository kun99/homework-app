import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'course.dart';
import 'homework.dart';
import 'notes.dart';

class DatabaseThangs {

  DatabaseThangs._();
  static final DatabaseThangs instance = DatabaseThangs._();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'entries.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE homework(
        id INTEGER PRIMARY KEY,
        title TEXT,
        course TEXT,
        date DATE
      )  
    ''');
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content MEDIUMTEXT
      )  
    ''');
    await db.execute('''
      CREATE TABLE courses(
        id INTEGER PRIMARY KEY,
        course TEXT
      )  
    ''');
  }

  Future<int> addHomework(Homework newHomework) async {
    Database db = await instance.database;
    var test = await db.insert('homework', newHomework.toMap());
    return test;
  }

  Future<List<Homework>> getHomework() async {
    final db = await database;
    final List<Map<String, dynamic>> homework = await db.query('homework', orderBy: "date ASC");
    List<Homework> homeworkList = homework.isNotEmpty
        ? homework.map((c) => Homework.fromMap(c)).toList() : [];
    return homeworkList;
  }

  Future<List<Homework>> getSingleHomework(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> singleHomework = await db.query(
      'homework',
      where: 'id = ?',
      whereArgs: [id],
    );
    List<Homework> singleHomeworkList = singleHomework.isNotEmpty
        ? singleHomework.map((c) => Homework.fromMap(c)).toList() : [];
    //list will only have one entry anyways.
    return singleHomeworkList;
  }

  Future<void> deleteHomework(int id) async {
    final db = await database;
    await db.delete(
      'homework',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> editHomework(int id, Homework homework) async {
    final db = await database;
    await db.update(
      'homework',
      homework.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addNote(Note newNote) async {
    Database db = await instance.database;
    var test = await db.insert('notes', newNote.toMap());
    return test;
  }

  Future<void> editNote(int id, Note note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> getNote(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> notes = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    List<Note> notesList = notes.isNotEmpty
        ? notes.map((c) => Note.fromMap(c)).toList() : [];
    //list will only have one entry anyways.
    return notesList;
  }

  /*not necessary for now */
  // Future<List<Note>> getNotes() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> notes = await db.query('notes');
  //   List<Note> notesList = notes.isNotEmpty
  //       ? notes.map((c) => Note.fromMap(c)).toList() : [];
  //   return notesList;
  // }

  Future<int> addCourse(Course newCourse) async {
    Database db = await instance.database;
    var test = await db.insert('courses', newCourse.toMap());
    return test;
  }

  Future<List<Course>> getCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> courses = await db.query('courses');
    List<Course> coursesList = courses.isNotEmpty
        ? courses.map((c) => Course.fromMap(c)).toList() : [];
    return coursesList;
  }

  Future<void> deleteCourse(int id) async {
    final db = await database;
    await db.delete(
      'courses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

