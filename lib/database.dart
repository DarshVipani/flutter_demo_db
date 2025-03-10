//import 2 packages sqflite and path provider

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{

  Future<Database> initDatabase() async{
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path,'cureOption.db');
    var db = await openDatabase(path,onCreate: (db,version) async{
        await db.execute('''
          create table State(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');
    },version: 1 ,
      onUpgrade: (db, oldVersion, newVersion) {

    },
    );
    return db;
  }

  Future<List<Map<String,dynamic>>> selectAllState() async{
    Database db = await initDatabase();
    return await db.rawQuery('SELECT * from State');
  }

  Future<void> insertState(Map<String, dynamic> mp) async {
    Database db = await initDatabase();
    int id = await db.insert('State', mp);
  }

  Future<void> deleteState(int id) async {
    Database db = await initDatabase();
    int num = await db.delete('State',where: 'id=?',whereArgs: [id]);
  }

  Future<void> updateState(Map<String, dynamic> mp)async {
    Database db = await initDatabase();
    int n = await db.update('State', mp,where: 'id=?',whereArgs: [mp['id']]);
  }
}