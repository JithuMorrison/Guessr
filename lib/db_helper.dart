import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hangman.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Table for max scores per category
    await db.execute(
      "CREATE TABLE max_scores(id INTEGER PRIMARY KEY, name TEXT, max_score INTEGER)",
    );

    // Table for daily scores
    await db.execute(
      "CREATE TABLE daily_scores(id INTEGER PRIMARY KEY, date TEXT, score INTEGER)",
    );

    // Insert initial data for "food" category
    await db.insert('max_scores', {'name': 'food', 'max_score': 0});
  }

  // Get the max score for a specific category
  Future<int> getMaxScore(String name) async {
    final db = await database;
    final scores = await db.query('max_scores', where: 'name = ?', whereArgs: [name]);
    if (scores.isNotEmpty) {
      return scores.first['max_score'] as int;
    }
    return 0;
  }

  // Update the max score for a specific category
  Future<void> updateMaxScore(String name, int score) async {
    final db = await database;
    await db.update(
      'max_scores',
      {'max_score': score},
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  // Insert a daily score
  Future<void> insertDailyScore(int score) async {
    final db = await database;
    final date = DateTime.now().toIso8601String();
    await db.insert('daily_scores', {'date': date, 'score': score});
  }
}