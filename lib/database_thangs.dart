import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'homework.dart';

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
  }

  Future<int> addHomework(Homework newHomework) async {
    Database db = await instance.database;
    var test = await db.insert('homework', newHomework.toMap());
    return test;
  }

  Future<List<Homework>> getHomework() async {
    final db = await database;
    final List<Map<String, dynamic>> homeworks = await db.query('homework');
    List<Homework> homeworkList = homeworks.isNotEmpty
        ? homeworks.map((c) => Homework.fromMap(c)).toList() : [];
    return homeworkList;
  }
}

