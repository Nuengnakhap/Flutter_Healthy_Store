import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/order.dart';

abstract class AppMethods {
  Future<String> loginUser({String email, String password});
  Future<String> createUserAccount(
      {String fullname, String phone, String email, String password});
  Future<String> updateUserAccount(
      {String fullname, String phone, String email, String password});
  Future<bool> logoutUser();
  Future<DocumentSnapshot> getUserInfo(String userId);
  Future<String> setAddress(
      {String userId,
      String fullname,
      String phone,
      String address,
      String province,
      String district,
      String zipcode,
      double latitude,
      double longtitude});
  Future<String> setOrderHistory({List<Order> order, String userID});
  Stream<QuerySnapshot> getOrderHistory();
}
