import 'package:flutter/rendering.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/dbModels/orders.dart';
import 'package:store_app_proj/tools/app_data.dart' as prefix0;
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
      String addressName,
      String fullname,
      String phone,
      String address,
      String province,
      String district,
      String zipcode,
      double latitude,
      double longitude}) async {
    try {
      await firestore
          .collection(usersData)
          .document(userId)
          .collection('address')
          .document()
          .setData({
        "addressname": addressName,
        "fullname": fullname,
        "phone": phone,
        "address": address,
        "province": province,
        "district": district,
        "zipcode": zipcode,
        "location": GeoPoint(latitude, longitude),
      });
      return null;
    } catch (e) {
      return errorMSG(e.message);
    }
  }

  Future<String> updateAddress(
      {DocumentReference ref,
      String addressName,
      String fullname,
      String phone,
      String address,
      String province,
      String district,
      String zipcode,
      double latitude,
      double longitude}) async {
    try {
      await ref.updateData({
        "addressname": addressName,
        "fullname": fullname,
        "phone": phone,
        "address": address,
        "province": province,
        "district": district,
        "zipcode": zipcode,
        "location": GeoPoint(latitude, longitude),
      });
      return null;
    } catch (e) {
      return errorMSG(e.message);
    }
  }

  @override
  Stream<QuerySnapshot> getAddress(String uid) {
    return firestore
        .collection(usersData)
        .document(uid)
        .collection('address')
        .snapshots();
  }

  Future<String> removeAddress(String uid, String aid) {
    try {
      firestore
          .collection(usersData)
          .document(uid)
          .collection('address')
          .document(aid)
          .delete();
      return null;
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
          userUID: user.uid,
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
  Future<String> setOrderHistory({List<Order> order, String userID}) async {
    try {
      Client _client = await DBProvider(dbName: 'Client').getLasted();
      // List orderID = List();
      // QuerySnapshot querySnapshot = await Firestore.instance
      //     .collection(usersData)
      //     .document(_client.userUID)
      //     .collection('orderHistory')
      //     .getDocuments().then((onValue) {
      //       onValue.documents.toList().forEach((f) {
      //         orderID.add(f.documentID);
      //       });
      //     });
      // print(orderID);
      // var list = querySnapshot;
      // print(list);
      if (_client != null) {
        var orders = Orders(lstOrd: order, user: _client.fullName);
        await firestore
            .collection('orderHistory')
            .document()
            .setData(orders.toMap());
        return successfulMSG();
      }
    } catch (e) {
      return errorMSG(e.message);
    }
    return errorMSG('error');
  }

  @override
  Stream<QuerySnapshot> getOrderHistory() {
    try {
      if (auth.currentUser() != null) {
        return firestore.collection('orderHistory').snapshots();
      }
    } catch (e) {
      print(e.message);
    }
    return null;
  }

  Future checkLastUser() async {
    return await DBProvider(dbName: 'Client').getLasted();
  }

  @override
  Future<String> setFavorite(Store product) async {
    try {
      Client _client = await checkLastUser();
      if (_client != null) {
        await firestore
            .collection(prefix0.usersData)
            .document(_client.userUID)
            .collection('favorites')
            .document(product.itemName)
            .setData({
          prefix0.pro_name: product.itemName,
          prefix0.pro_image: product.itemImage,
          prefix0.pro_price: product.itemPrice,
          prefix0.pro_desc: product.itemDesc,
          prefix0.pro_rating: product.itemRating,
        });
        return successfulMSG();
      }
    } catch (e) {
      return errorMSG(e.message);
    }
    return errorMSG('error');
  }

  @override
  Future<String> removeFavorite(Store product) async {
    try {
      Client _client = await checkLastUser();
      if (_client != null) {
        await firestore
            .collection(prefix0.usersData)
            .document(_client.userUID)
            .collection('favorites')
            .document(product.itemName)
            .delete();
        return successfulMSG();
      }
    } catch (e) {
      return errorMSG(e.message);
    }
    return null;
  }

  Future<String> updateUserAccount(
      {String fullname, String phone, String email, String password}) async {
    FirebaseUser user;
    try {
      user = await auth.currentUser();
      if (user != null) {
        user.updateEmail(email);
        user.updatePassword(password);
      }
      await firestore.collection(usersData).document(user.uid).updateData({
        userID: user.uid,
        acctFullName: fullname,
        userEmail: email,
        userPassword: password,
        phoneNumber: phone,
        photoURL: '',
      });
      Client client = await checkLastUser();
      client.fullName = fullname;
      client.phone = phone;
      client.password = password;
      client.email = email;
      await DBProvider(dbName: 'Client').updateDB(client);
    } on PlatformException catch (e) {
      return errorMSG(e.message);
    }
    return user == null ? errorMSG('Error') : successfulMSG();
  }

  @override
  Future<List<DocumentSnapshot>> getFavs() async {
    Client _client = await checkLastUser();
    try {
      if (_client != null) {
        List<DocumentSnapshot> dd;
        await firestore
            .collection(usersData)
            .document(_client.userUID)
            .collection('favorites')
            .getDocuments()
            .then((f) {
          dd = f.documents;
        });
        return dd;
      }
    } catch (e) {
      print(e.message);
    }
    return null;
  }
}
