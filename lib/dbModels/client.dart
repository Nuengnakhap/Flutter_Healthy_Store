import 'package:store_app_proj/tools/app_data.dart';

class Client {
  int id;
  String userUID;
  String fullName;
  String phone;
  String email;
  String password;
  String photo;
  bool logged;
  static String cmdInitDB = "CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$userID TEXT,"
          "$acctFullName TEXT,"
          "$phoneNumber TEXT,"
          "$userEmail TEXT,"
          "$userPassword TEXT,"
          "$photoURL TEXT,"
          "$loggedIN INTEGER"
          ")";

  Client({
    this.id,
    this.userUID,
    this.fullName,
    this.phone,
    this.email,
    this.password,
    this.photo,
    this.logged,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json['id'],
        userUID: json[userID],
        fullName: json[acctFullName],
        phone: json[phoneNumber],
        email: json[userEmail],
        password: json[userPassword],
        photo: json[photoURL],
        logged: json[loggedIN] == 1,
      );

  Map<String, dynamic> toMap() => {
        userID: userUID,
        acctFullName: fullName,
        phoneNumber: phone,
        userEmail: email,
        userPassword: password,
        photoURL: photo,
        loggedIN: logged == true ? 1 : 0,
      };
}