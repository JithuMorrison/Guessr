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
      "CREATE TABLE max_scores(id INTEGER PRIMARY KEY, name TEXT UNIQUE, max_score INTEGER)",
    );

    // Table for daily scores
    await db.execute(
      "CREATE TABLE daily_scores(id INTEGER PRIMARY KEY, date TEXT UNIQUE, score INTEGER)",
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

  // Update the max score for a specific category, create a new entry if not present
  Future<void> updateMaxScore(String name, int score) async {
    final db = await database;

    // Check if the category exists
    final existing = await db.query('max_scores', where: 'name = ?', whereArgs: [name]);

    if (existing.isNotEmpty) {
      // Update existing record
      await db.update(
        'max_scores',
        {'max_score': score},
        where: 'name = ?',
        whereArgs: [name],
      );
    } else {
      // Insert new record with default max_score = 0
      await db.insert('max_scores', {'name': name, 'max_score': 0});
    }
  }

  // Insert a daily score only if the date is not already present
  Future<void> insertDailyScore(int score) async {
    final db = await database;
    final date = DateTime.now().toIso8601String().split('T')[0]; // Only store YYYY-MM-DD

    // Check if the date already exists
    final existing = await db.query('daily_scores', where: 'date = ?', whereArgs: [date]);

    if (existing.isEmpty) {
      // Insert only if the date is not already present
      await db.insert('daily_scores', {'date': date, 'score': score});
    }
  }
}
