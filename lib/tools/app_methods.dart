import 'dart:async';

abstract class AppMethods {
  Future<String> loginUser({String email, String password});
  Future<String> createUserAccount({String fullname, String phone, String email, String password});
}
