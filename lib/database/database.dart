import 'package:path/path.dart' show join;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static const databaseName = 'fitnessApp.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName), version: 1, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ${ExerciseFavorite.tableName} (id INTEGER,title TEXT,image TEXT,type TEXT,time TEXT,PRIMARY KEY(id AUTOINCREMENT))');
      await db.execute('CREATE TABLE ${MealsFavorite.tableName} (id INTEGER,title TEXT,image TEXT,kcal TEXT,PRIMARY KEY(id AUTOINCREMENT))');
    });
  }

  ///ExerciseFavorite

  Future<int> addExercise(ExerciseFavorite todo) async {
    final db = await database;
    return await db.insert(ExerciseFavorite.tableName, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ExerciseFavorite>> getAllExercise() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(ExerciseFavorite.tableName);
    final List<ExerciseFavorite> list = [];
    for (final element in maps) {
      list.add(ExerciseFavorite.fromJson(element));
    }
    return list;
  }

  Future<bool> getExerciseId({id}) async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.rawQuery('SELECT * FROM ${ExerciseFavorite.tableName} WHERE id = $id');
    return data.isNotEmpty;
  }

  Future<int> deleteExercise({required int id}) async {
    final db = await database;
    return await db.delete(ExerciseFavorite.tableName, where: 'id = ?', whereArgs: [id]);
  }

  ///MealsFavorite

  Future<int> addMeals(MealsFavorite todo) async {
    final db = await database;
    return await db.insert(MealsFavorite.tableName, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> getMealsId({id}) async {
    final db = await database;
    final List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM ${MealsFavorite.tableName} WHERE id = $id');
    return list.isNotEmpty;
  }

  Future<List<MealsFavorite>> getAllMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(MealsFavorite.tableName);
    final List<MealsFavorite> list = [];
    for (final element in maps) {
      list.add(MealsFavorite.fromJson(element));
    }
    return list;
  }

  Future<int> deleteMeals({required int id}) async {
    final db = await database;
    return await db.delete(MealsFavorite.tableName, where: 'id = ?', whereArgs: [id]);
  }
}

///modal class

class ExerciseFavorite {
  static const String tableName = "exercise";
  final int id;
  final String title;
  final String image;
  final String type;
  final String time;

  const ExerciseFavorite({required this.id, required this.title, required this.image, required this.type, required this.time});

  Map<String, dynamic> toMap() => {'id': id, 'title': title, "image": image, "type": type, "time": time};

  factory ExerciseFavorite.fromJson(Map<String, dynamic> json) => ExerciseFavorite(image: json['image'], id: json['id'], time: json['time'], title: json['title'], type: json['type']);
}

class MealsFavorite {
  static const String tableName = "meals";
  final int id;
  final String title;
  final String image;
  final String kcal;

  const MealsFavorite({required this.id, required this.title, required this.image, required this.kcal});

  Map<String, dynamic> toMap() => {'id': id, 'title': title, "image": image, "kcal": kcal};

  factory MealsFavorite.fromJson(Map<String, dynamic> json) => MealsFavorite(image: json['image'], id: json['id'], kcal: json['kcal'], title: json['title']);
}
