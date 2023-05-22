// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._privateConstructor();

  factory DBHelper() {
    return _instance;
  }

  DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'example.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE images (
          id INTEGER PRIMARY KEY,
          path TEXT,
          is_favourite BOOLEAN
        )
      ''');

      },
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<int> insertImages(Map<String, dynamic> row) async {
    final db = await database;
    return db.insert('images', row);
  }

  // Future<int> insertTimetable(Map<String, dynamic> row) async {
  //   final db = await database;
  //   return await db.insert('timetable', row);
  // }

  // Future<List<Map<String, dynamic>>> getTimetableAll(int historyId) async {
  //   final db = await database;
  //   return await db.query('timetable', where: 'history_id = ?', whereArgs: [historyId]);
  // }

  Future<int> deleteImage(int id) async {
    final db = await database;
    return await db.delete('images', where: 'id = ?', whereArgs: [id]);
  }

  

  // Future<List<Map<String, dynamic>>> getHistory(String type) async {
  //   final db = await database;
  //   return await db
  //       .query('history', where: 'type_history = ?', whereArgs: [type]);
  // }

  // Future<List<Map<String, dynamic>>> getTimetable(
  //     int historyId, var day) async {
  //   final db = await database;
  //   return await db.query('timetable',
  //       where: 'history_id = ? AND day = ?', whereArgs: [historyId, day]);
  // }

  // Future<int> deleteHistory(int id) async {
  //   final db = await database;
  //   return await db.delete('history', where: 'id = ?', whereArgs: [id]);
  // }
  // These are for the qrcode

  // Future<List<Map<String, Object?>>> getHistoryById(int id) async {
  //   final db = await database;
  //   return await db.query('history', where: 'id = ?', whereArgs: [id]);
  // }

  // Future<List<Map<String, dynamic>>> getTimetableByHistoryId(
  //     int historyId) async {
  //   final db = await database;
  //   return await db
  //       .query('timetable', where: 'history_id = ?', whereArgs: [historyId]);
  // }

// this for storing data temporary during storing
//   Future<int> insertDataBefore(Map<String, dynamic> row) async {
//     final db = await database;
//     return await db.insert('data_before', row);
//   }

  Future<List<Map<String, dynamic>>> getImages() async {
    final db = await database;
    return await db.query('images');
  }

  Future<List<Map<String, dynamic>>> getFavouriteImages() async {
    var isFavourite = true;
    final db = await database;
    return await db.query('images', where: 'is_favourite = ?',  whereArgs: [isFavourite]);
  }

  // Future<List<Map<String, dynamic>>> getDataBeforeAtDay(String day) async {
  //   final db = await database;
  //   return await db.query('data_before', where: 'day = ?', whereArgs: [day]);
  // }
  //
  Future<int> toFavourite(int id) async {
    final db = await database;
    return await db.update('images',{'is_favourite': true}, where: 'id = ?', whereArgs: [id]);
  }
  Future<int> notToFavourite(int id) async {
    final db = await database;
    return await db.update('images',{'is_favourite': false}, where: 'id = ?', whereArgs: [id]);
  }
}
