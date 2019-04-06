import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tools/progressdialog.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'app_data.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    String type,
    double sidePadding,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = '' : textHint;
  TextInputType txtType;
  if (type == 'Email') {
    txtType = TextInputType.emailAddress;
  } else if (type == 'Phone') {
    txtType = TextInputType.number;
  } else {
    txtType = null;
  }
  return Padding(
    padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: controller,
        obscureText: type == 'Password' ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textHint,
          prefixIcon: textIcon == null ? Container() : Icon(textIcon),
        ),
        keyboardType: txtType,
      ),
    ),
  );
}

Widget appButton(
    {String btnTxt,
    double btnPadding,
    Color btnColor,
    VoidCallback onBtnclicked}) {
  btnTxt == null ? btnTxt = 'App Button' : btnTxt;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: EdgeInsets.all(btnPadding),
    child: RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      onPressed: onBtnclicked,
      child: Container(
        height: 45.0,
        child: Center(
          child: Text(
            btnTxt,
            style: TextStyle(
              color: btnColor,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    ),
  );
}

showSnackbar(String message, final key) {
  key.currentState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[600],
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

displayProgressDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ProgressDialog();
      }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

writeDataLocally({String key, String value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setString(key, value);
}

// SQLLite
// Client clientFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Client.fromMap(jsonData);
// }

// String clientToJson(Client data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }

// class Client {
//   int id;
//   String userUID;
//   String fullName;
//   String phone;
//   String email;
//   String password;
//   String photo;
//   bool logged;

//   Client({
//     this.id,
//     this.userUID,
//     this.fullName,
//     this.phone,
//     this.email,
//     this.password,
//     this.photo,
//     this.logged,
//   });

//   factory Client.fromMap(Map<String, dynamic> json) => new Client(
//         id: json['id'],
//         userUID: json[userID],
//         fullName: json[acctFullName],
//         phone: json[phoneNumber],
//         email: json[userEmail],
//         password: json[userPassword],
//         photo: json[photoURL],
//         logged: json[loggedIN] == 1,
//       );

//   Map<String, dynamic> toMap() => {
//         userID: userUID,
//         acctFullName: fullName,
//         phoneNumber: phone,
//         userEmail: email,
//         userPassword: password,
//         photoURL: photo,
//         loggedIN: logged == true ? 1 : 0,
//       };
// }

// class DBProvider {
//   // DBProvider._();

//   // static final DBProvider db = DBProvider._();

//   Database _database;
//   String dbName;
//   DBProvider({@required this.dbName});

//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "TestDB.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Client ("
//           "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//           "$userID TEXT,"
//           "$acctFullName TEXT,"
//           "$phoneNumber TEXT,"
//           "$userEmail TEXT,"
//           "$userPassword TEXT,"
//           "$photoURL TEXT,"
//           "$loggedIN INTEGER"
//           ")");
//     });
//   }

//   newClient(Client newClient) async {
//     final db = await database;
//     //get the biggest id in the table
//     // var table =
//     //     await db.rawQuery("SELECT MAX($userID)+1 as $userID FROM Client");
//     // int id = table.first["$userID"];
//     // //insert to the table using the new id
//     // var raw = await db.rawInsert(
//     //     "INSERT Into Client ($userID,$acctFullName,$phoneNumber,$userEmail,$userPassword,$photoURL,$loggedIN)"
//     //     " VALUES (?,?,?,?,?,?,?)",
//     //     [
//     //       newClient.userUID,
//     //       newClient.fullName,
//     //       newClient.phone,
//     //       newClient.email,
//     //       newClient.password,
//     //       newClient.photo,
//     //       newClient.logged
//     //     ]);
//     // return raw;
//     newClient.id = await db.insert('Client', newClient.toMap());
//     return newClient;
//   }

//   blockOrUnblock(Client client) async {
//     final db = await database;
//     Client blocked = Client(
//         id: client.id,
//         userUID: client.userUID,
//         fullName: client.fullName,
//         phone: client.phone,
//         email: client.email,
//         password: client.password,
//         photo: client.photo,
//         logged: !client.logged);
//     var res = await db.update("Client", blocked.toMap(),
//         where: "id = ?", whereArgs: [client.id]);
//     return res;
//   }

//   updateClient(Client newClient) async {
//     final db = await database;
//     var res = await db.update("Client", newClient.toMap(),
//         where: "id = ?", whereArgs: [newClient.id]);
//     return res;
//   }

//   getClient(int id) async {
//     final db = await database;
//     var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Client.fromMap(res.first) : null;
//   }

//   Future<List<Client>> getBlockedClients() async {
//     final db = await database;

//     print("works");
//     // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//     var res = await db.query("Client", where: "$loggedIN = ? ", whereArgs: [1]);

//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

//   Future<List<Client>> getAllClients() async {
//     final db = await database;
//     var res = await db.query("Client");
//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

//   deleteClient(int id) async {
//     final db = await database;
//     return db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }

//   deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete from Client");
//   }
// }
