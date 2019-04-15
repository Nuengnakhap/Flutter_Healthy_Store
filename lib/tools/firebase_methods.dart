import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_data.dart';
import 'package:flutter/services.dart';

class FirebaseMethods implements AppMethods {
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<String> createUserAccount(
      {String fullname, String phone, String email, String password}) async {
    FirebaseUser user;

    try {
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        await firestore.collection(usersData).document(user.uid).setData({
          userID: user.uid,
          acctFullName: fullname,
          userEmail: email,
          userPassword: password,
          phoneNumber: phone,
          photoURL: '',
        });

        // writeDataLocally(key: userID, value: user.uid);
        // writeDataLocally(key: acctFullName, value: fullname);
        // writeDataLocally(key: userEmail, value: email);
        // writeDataLocally(key: userPassword, value: password);
        // writeDataLocally(key: phoneNumber, value: phone);
      }
      // List result =
      //     await DBProvider(dbName: 'Client', cmdInitDB: Client.cmdInitDB)
      //         .getAllDB();
      // for (Client item in result) {
      //   print(item.toMap());
      // }
    } on PlatformException catch (e) {
      return errorMSG(e.message);
    }

    return user == null ? errorMSG('Error') : successfulMSG();
  }

  @override
  Future<String> loginUser({String email, String password}) async {
    FirebaseUser user;

    try {
      user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        DocumentSnapshot userInfo = await getUserInfo(user.uid);
        await DBProvider(dbName: 'Client')
            .newDB(Client(
          userUID: userInfo[userID],
          fullName: userInfo[acctFullName],
          email: userInfo[userEmail],
          password: userInfo[userPassword],
          phone: userInfo[phoneNumber],
          photo: userInfo[photoURL],
          logged: true,
        ));
      }
      // List result =
      //     await DBProvider(dbName: 'Client', cmdInitDB: Client.cmdInitDB)
      //         .getAllDB();
      // for (Client item in result) {
      //   print(item.toMap());
      // }
    } on PlatformException catch (e) {
      return errorMSG(e.message);
    }

    return user == null ? errorMSG('Error') : successfulMSG();
  }

  Future<bool> complete() async {
    return true;
  }

  Future<bool> notComplete() async {
    return false;
  }

  Future<String> successfulMSG() async {
    return successful;
  }

  Future<String> errorMSG(String e) async {
    return e.toString();
  }

  @override
  Future<bool> logoutUser() async {
    await auth.signOut();
    await DBProvider(dbName: 'Client').deleteAll();
    return complete();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userId) async {
    return await firestore.collection(usersData).document(userId).get();
  }
}
