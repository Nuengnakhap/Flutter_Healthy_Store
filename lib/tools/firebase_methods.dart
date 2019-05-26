import 'package:store_app_proj/dbModels/Store.dart';
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
  Future<String> setAddress(
      {String userId,
      String fullname,
      String phone,
      String address,
      String province,
      String district,
      String zipcode,
      double latitude,
      double longtitude}) async {
    try {
      await firestore
          .collection(usersData)
          .document(userId)
          .collection('address')
          .document()
          .setData({
        fullname: fullname,
        phone: phone,
        address: address,
        province: province,
        district: district,
        zipcode: zipcode,
        location: GeoPoint(latitude, longtitude),
      });
      return successfulMSG();
    } catch (e) {
      return errorMSG(e.message);
    }
  }

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
        await DBProvider(dbName: 'Client').newDB(Client(
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

  @override
  Future<String> setOrderHistory({Store product, int quantity}) async {
    try {
      Client _client = await DBProvider(dbName: 'Client').getLasted();
      if (_client != null) {
        await firestore
            .collection(usersData)
            .document(_client.userUID)
            .collection('orderHistory')
            .document()
            .setData({
          c_pro_name: product.itemName,
          c_pro_price: product.itemPrice,
          c_pro_image: product.itemImage,
          c_pro_rating: product.itemRating,
          c_pro_desc: product.itemDesc,
          c_pro_quantity: quantity,
        });
        return successfulMSG();
      }

    } catch (e) {
      return errorMSG(e.message);
    }
    return errorMSG('error');
  }
}
