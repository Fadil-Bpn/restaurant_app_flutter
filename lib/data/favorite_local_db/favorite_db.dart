import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/restaurant.dart';
import '../model/class/menus.dart';

class FavoriteDb {
  static final FavoriteDb _instance = FavoriteDb._internal();
  static Database? _database;

  FavoriteDb._internal();
  factory FavoriteDb() => _instance;

  static const String _tableFavorite = 'favorite';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'restaurant.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      _tableFavorite,
      {
        "id": restaurant.id,
        "name": restaurant.name,
        "city": restaurant.city,
        "pictureId": restaurant.pictureId,
        "rating": restaurant.rating,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final results = await db.query(_tableFavorite);

    return results.map((row) {
      return Restaurant(
        id: row['id'] as String,
        name: row['name'] as String,
        description: '',
        city: row['city'] as String,
        address: '',
        pictureId: row['pictureId'] as String,
        categories: [],
        menus: Menus(foods: [], drinks: []),
        rating: (row['rating'] as num).toDouble(),
        customerReviews: [],
      );
    }).toList();
  }

  Future<Restaurant?> getFavoriteById(String id) async {
    final db = await database;
    final results = await db.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      final row = results.first;
      return Restaurant(
        id: row['id'] as String,
        name: row['name'] as String,
        description: '',
        city: row['city'] as String,
        address: '',
        pictureId: row['pictureId'] as String,
        categories: [],
        menus: Menus(foods: [], drinks: []),
        rating: (row['rating'] as num).toDouble(),
        customerReviews: [],
      );
    }
    return null;
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result = await db.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
