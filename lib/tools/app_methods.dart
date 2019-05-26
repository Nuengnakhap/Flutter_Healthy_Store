import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppMethods {
  Future<String> loginUser({String email, String password});
  Future<String> createUserAccount({String fullname, String phone, String email, String password});
  Future<bool> logoutUser();
  Future<DocumentSnapshot> getUserInfo(String userId);
  Future<String> setAddress({String addressName, String fullname, String phone, String address, String province, String district, String zipcode, double latitude, double longitude});
}
