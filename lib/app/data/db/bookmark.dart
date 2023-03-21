import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db!;
  }

  Future initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();

    String path = join(docDir.path, "bookmark.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute('''
            CREATE TABLE bookmark (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              surah TEXT NOT NULL,
              ayat INTEGER NOT NULL,
              juz INTEGER NOT NULL,
              via INTEGER NOT NULL,
              index_ayat TEXT NOT NULL,
              last_read INTEGER DEFAULT 0
            )
          ''');
      },
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
