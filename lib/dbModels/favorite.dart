import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/tools/app_data.dart';
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
    // List dd = await DBProvider(dbName: 'Cart').getAllDB();
    List<DocumentSnapshot> fav = await appMethod.getFavs();
    if (fav != null && fav.length > 0) {
      fav.forEach((f) {
        _product.add(Store.items(
          itemName: f.data[pro_name],
          itemDesc: f.data[pro_desc],
          itemImage: f.data[pro_image],
          itemPrice: f.data[pro_price],
          itemRating: f.data[pro_rating],
        ));
      });
    }
  }

  void addProduct(Store product) async {
    _product.add(product);
    await appMethod.setFavorite(product);
  }

  void removeProduct(Store product) {
    Store lst;
    _product.forEach((f) {
      if (f.itemName == product.itemName) {
        lst = f;
      }
    });
    _product.remove(lst);
  }

  void removeAllProduct() async {
    _product.forEach((f) async {
      await appMethod.removeFavorite(f);
    });
    _product.clear();
  }

  void clearFavorite() {
    _product.clear();
  }

  List<Store> get products => _product;

  int get productsCount => _product.length;

  bool get isEmpty => _product.length == 0;
}
