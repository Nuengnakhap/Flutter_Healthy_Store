import 'dart:async';

import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';

class Favorite {
  List<Store> _product;
  AppMethods appMethod = FirebaseMethods();

  Favorite() {
    _product = List();
    fetchFavorite();
  }

  Future fetchFavorite() async {
    List dd = await DBProvider(dbName: 'Cart').getAllDB();
    for (var item in dd) {
      _product.add(item);
    }
  }

  void addProduct(Store product) async {
    _product.add(product);
    await appMethod.setFavorite(product);
  }

  void removeProduct(Store product) async{
    _product.remove(product);
    await appMethod.removeFavorite(product);
  }

  void removeAllProduct() async {
    Client _client = await DBProvider(dbName: 'Client').getLasted();
    // await appMethod.setOrderHistory(order: _product, userID: _client.userUID);
    _product.clear();
  }

  void clearFavorite() {
    _product.clear();
  }

  List<Store> get products => _product;

  int get productsCount => _product.length;

  bool get isEmpty => _product.length == 0;
}
