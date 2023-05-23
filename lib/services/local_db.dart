import 'package:kawai/models/wallpaper_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class LocalStorage {
  Future<sql.Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'wallpapers.db'),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE user_wallpapers(id TEXT PRIMARY KEY, liked INTEGER, path TEXT)');
    }, version: 1);
    return db;
  }

  Future insert({required WallPaper wallpaper}) async {
    try {
      final db = await init();
      await db.insert('user_wallpapers', {
        'id': wallpaper.id,
        'path': wallpaper.path,
        'liked': 0,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WallPaper>> getData() async {
    try {
      final db = await init();
      final data = await db.query('user_wallpapers');
      final List<WallPaper> wallpapers = data.map((row) {
        return WallPaper(
            id: row['id'] as String,
            path: row['path'] as String,
            favourite: row['liked'] == null ? 0 : row['liked'] as int);
      }).toList();
      return wallpapers;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteRow(String id) async {
    try {
      final db = await init();
      await db.delete('user_wallpapers', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<WallPaper>> getFavourite() async {
    try {
      final db = await init();

      final data =
          await db.query('user_wallpapers', where: 'liked', whereArgs: [1]);
      final List<WallPaper> wallpapers = data.map((row) {
        return WallPaper(
            id: row['id'] as String,
            path: row['path'] as String,
            favourite: row['liked'] as int);
      }).toList();
      return wallpapers;
    } catch (e) {
      rethrow;
    }
  }

  Future updateRow({required WallPaper wallpaper}) async {
    try {
      final db = await init();
      await db.rawDelete(
          'DELETE FROM user_wallpapers WHERE id = ?', [wallpaper.id]);
      await insert(wallpaper: wallpaper);
    } catch (e) {
      rethrow;
    }
  }

  Future deleteAll() async {
    try {
      final db = await init();
      await db.delete('user_wallpapers');
    } catch (e) {
      rethrow;
    }
  }
}
