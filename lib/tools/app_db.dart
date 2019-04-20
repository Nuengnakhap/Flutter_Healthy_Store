import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_data.dart';

class DBProvider {
  // DBProvider._();

  // static final DBProvider db = DBProvider._();

  Database _database;

  String dbName;

  DBProvider({@required this.dbName});

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Store.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Cart("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$c_pro_name TEXT,"
          "$c_pro_price DOUBLE,"
          "$c_pro_image TEXT,"
          "$c_pro_rating TEXT,"
          "$c_pro_desc TEXT,"
          "$c_pro_quantity INTEGER"
          ")");
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$userID TEXT,"
          "$acctFullName TEXT,"
          "$phoneNumber TEXT,"
          "$userEmail TEXT,"
          "$userPassword TEXT,"
          "$photoURL TEXT,"
          "$loggedIN INTEGER"
          ")");
    });
  }

  newDB(object) async {
    final db = await database;
    object.id = await db.insert(dbName, object.toMap());
    return object;
  }

  blockOrUnblock(object) async {
    final db = await database;
    dynamic blocked;
    if (object is Client) {
      blocked = Client(
          id: object.id,
          userUID: object.userUID,
          fullName: object.fullName,
          phone: object.phone,
          email: object.email,
          password: object.password,
          photo: object.photo,
          logged: !object.logged);
    }

    var res = await db.update(dbName, blocked.toMap(),
        where: "id = ?", whereArgs: [object.id]);
    return res;
  }

  updateDB(object) async {
    final db = await database;
    var res = await db.update(dbName, object.toMap(),
        where: "id = ?", whereArgs: [object.id]);
    return res;
  }

  getDB(String id) async {
    final db = await database;
    var res = await db.query(dbName, where: "$userID = ?", whereArgs: [id]);
    if (dbName == 'Client') {
      return res.isNotEmpty ? Client.fromMap(res.first) : null;
    }
  }

  getLasted() async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM $dbName WHERE id = (SELECT max(id) FROM $dbName)");
    if (dbName == 'Client') {
      return res.isNotEmpty ? Client.fromMap(res.first) : null;
    }
  }

  Future<List<Client>> getBlockedClients() async {
    final db = await database;

    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "$loggedIN = ? ", whereArgs: [1]);

    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List> getAllDB() async {
    final db = await database;
    var res = await db.query(dbName);
    List list;

    if (dbName == 'Client') {
      list = res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    }

    if (dbName == 'Cart') {
      list = res.isNotEmpty ? res.map((c) => Order.fromMap(c)).toList() : [];
    }
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete(dbName, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete from $dbName");
  }
}
