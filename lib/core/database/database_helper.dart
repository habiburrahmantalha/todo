import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/core/database/task_db_model.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the tasks table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id TEXT,
        duration INTEGER NOT NULL,
        start_time TEXT NOT NULL
      )
    ''');
  }

  // Insert a new task into the database
  Future<int> insertTask(TaskDB task) async {
    final db = await database;
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all tasks from the database
  Future<List<TaskDB>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return TaskDB.fromMap(maps[i]);
    });
  }

  // Fetch a single task by ID
  Future<TaskDB?> getTaskById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'task_id = ?',
      whereArgs: [id],
      limit: 1,
    );

    // Check if a task is found
    if (maps.isNotEmpty) {
      return TaskDB.fromMap(maps.first);
    } else {
      return null; // Return null if no task is found
    }
  }

  // Update a task in the database
  Future<int> updateTask(TaskDB task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'task_id = ?',
      whereArgs: [task.taskId],
    );
  }

  // Delete a task from the database
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'task_id = ?',
      whereArgs: [id],
    );
  }
}
