import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'task_database.db');
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        completeStatus INTEGER,
        startTime INTEGER,
        endTime INTEGER
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    Database? db = await database;
    return await db!.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    Database? db = await database;
    List<Map<String, dynamic>> maps = await db!.query('tasks');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> getCompletedTasks() async {
    Database? db = await database;
    var result = await db!.query('tasks', where: 'completeStatus = ?', whereArgs: [1]);
    return result.map((item) => Task.fromMap(item)).toList();
  }

  Future<int> updateTask(Task task) async {
    Database? db = await database;
    return await db!.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    Database? db = await database;
    return await db!.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
