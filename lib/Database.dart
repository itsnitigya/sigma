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
    //await deleteDatabase(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Tag ("
          "id TEXT,"
          "title TEXT,"
          "displayName TEXT,"
          "meta TEXT,"
          "description TEXT"
          ")");
    });
  }

  insertAllTags(List<Tag> newTags) async {
    final db = await database;
    print("added");
    try {
      newTags.forEach((newTag) async {
        if (newTag.meta == null) {
          newTag.meta = "";
        }
        await db.rawInsert(
            "INSERT into Tag (id,title,displayName,meta,description)"
            " VALUES (?,?,?,?,?)",
            [
              newTag.id,
              newTag.title,
              newTag.displayName,
              newTag.meta,
              newTag.description
            ]);
      });
    } catch (err) {
      print(err);
    }
    return null;
  }

  Future<List<Tag>> getTags() async {
    final db = await database;
    List<Map> result = await db.query("Tag");
    List<Tag> items = [];
    result.forEach((element) {
      print(element["id"]);
      Tag tag = new Tag(
          id: element["id"],
          title: element["title"],
          displayName: element["displayName"],
          meta: element["meta"],
          description: element["description"]);
      items.add(tag);
    });
    return items;
  }

  deleteTag(String id) async {
    final db = await database;
    return db.delete("Tag", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Tag");
  }
}
