import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'Model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Welcome ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "blocked BIT"
          ")");
    });
  }

  // newWelcome(Welcome newWelcome) async {
  //   final db = await database;
  //   //get the biggest id in the table
  //   var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Welcome");
  //   int id = table.first["id"];
  //   //insert to the table using the new id
  //   var raw = await db.rawInsert(
  //       "INSERT Into Welcome (id,first_name,last_name,blocked)"
  //       " VALUES (?,?,?,?)",
  //       [id, newWelcome.firstName, newWelcome.lastName, newWelcome.blocked]);
  //   return raw;
  // }

  // blockOrUnblock(Welcome Welcome) async {
  //   final db = await database;
  //   Welcome blocked = Welcome(
  //       id: Welcome.id,
  //       firstName: Welcome.firstName,
  //       lastName: Welcome.lastName,
  //       blocked: !Welcome.blocked);
  //   var res = await db.update("Welcome", blocked.toMap(),
  //       where: "id = ?", whereArgs: [Welcome.id]);
  //   return res;
  // }

  // updateWelcome(Welcome newWelcome) async {
  //   final db = await database;
  //   var res = await db.update("Welcome", newWelcome.toMap(),
  //       where: "id = ?", whereArgs: [newWelcome.id]);
  //   return res;
  // }

  // getWelcome(int id) async {
  //   final db = await database;
  //   var res = await db.query("Welcome", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Welcome.fromMap(res.first) : null;
  // }

  // Future<List<Welcome>> getBlockedWelcomes() async {
  //   final db = await database;

  //   print("works");
  //   // var res = await db.rawQuery("SELECT * FROM Welcome WHERE blocked=1");
  //   var res = await db.query("Welcome", where: "blocked = ? ", whereArgs: [1]);

  //   List<Welcome> list =
  //       res.isNotEmpty ? res.map((c) => Welcome.fromMap(c)).toList() : [];
  //   return list;
  // }

  // Future<List<Welcome>> getAllWelcomes() async {
  //   final db = await database;
  //   var res = await db.query("Welcome");
  //   List<Welcome> list =
  //       res.isNotEmpty ? res.map((c) => Welcome.fromMap(c)).toList() : [];
  //   return list;
  // }

  deleteWelcome(int id) async {
    final db = await database;
    return db.delete("Welcome", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Welcome");
  }
}
