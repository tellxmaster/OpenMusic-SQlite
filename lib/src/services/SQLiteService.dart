// ignore: file_names
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Song.dart';

class SQLiteService {
  static Database? _database;

  static Future<void> createDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'songs_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE songs(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, artist TEXT, album TEXT, duration INTEGER, url TEXT, image_url TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> deleteDatabase() async {
    return await _database?.execute('DELETE FROM songs');
  }

  static Future<void> insertSong(Song song) async {
    await _database!.insert(
      'songs',
      song.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Song>> listSongs() async {
    final List<Map<String, dynamic>> maps = await _database!.query('songs');
    return List.generate(maps.length, (i) {
      return Song(
        id: maps[i]['id'],
        title: maps[i]['title'],
        artist: maps[i]['artist'],
        album: maps[i]['album'],
        duration: maps[i]['duration'],
        url: maps[i]['url'],
        imageUrl: maps[i]['image_url'],
      );
    });
  }
}
