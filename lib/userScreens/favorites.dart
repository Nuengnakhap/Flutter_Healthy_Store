import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/components/product_favorite.dart';
import 'package:store_app_proj/components/products.dart';
import 'package:store_app_proj/components/shopping_cart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/tools/progressdialog.dart';
import 'package:store_app_proj/userScreens/HomeScreen.dart';
import 'adminChat.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'delivery.dart';
import 'about.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color firstColor = Color.fromRGBO(29, 233, 182, 1);
Color secondColor = Color.fromRGBO(0, 96, 100, 1);
Color green = Color(0xFF272D34);

class FavoritesScreen extends StatefulWidget {
  @override
  FavoritesScreennState createState() => FavoritesScreennState();
}

class FavoritesScreennState extends State<FavoritesScreen> {
  BuildContext context;

  Client _client;
  String acctName = 'Guest';
  String acctEmail = '';
  String acctPhotoUrl = '';
  bool isLoggedIn = false;
  String adminId;
  String userId = '';
  String id;
  String peer;
  String groupchatId;
  AppMethods appMethod = FirebaseMethods();
  List<Store> st = List<Store>();
  StreamController _productController;

  @override
  void initState() {
    super.initState();
    _asyncMethod().then((v) {
      loadProducts();
    });
    _productController = StreamController();
  }

  Future _asyncMethod() async {
    _client = await DBProvider(dbName: 'Client').getLasted();
    if (_client != null) {
      acctName = _client.fullName;
      acctEmail = _client.email;
      acctPhotoUrl = _client.photo;
      isLoggedIn = _client.logged;
      userId = _client.userUID;
    } else {
      acctName = 'Guest';
      acctEmail = '';
      acctPhotoUrl = '';
      isLoggedIn = false;
      userId = '';
    }
    setState(() {});
  }

  Future fetchProduct() async {
    final response =
        await http.get('http://onezlinks.com:8090/files/product.json');
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var rest = data['items'] as List;
        List<Store> stores = rest.map((json) => Store.fromJson(json)).toList();
        // for (var i = 0; i < stores.length; i++) {
        //   if (stores[i] == null) {
        //     stores.remove(stores[i]);
        //   }
        // }
        stores.removeWhere((item) => item == null);
        return stores;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  loadProducts() {
    fetchProduct().then((res) {
      Firestore.instance
          .collection("usersData")
          .document(userId)
          .collection('favorites')
          .snapshots()
          .forEach((r) {
        r.documents.forEach((r) {
          Firestore.instance
              .collection("usersData")
              .document(userId)
              .collection('favorites')
              .document(r.documentID)
              .get()
              .then((v) {
            for (int i = 0; i < res.length; i++) {
              if (v['item'] == res[i].itemName) {
                if (v['T/F'] == 1) {
                  print("Kuy : ${res[i]}");
                  setState(() {
                    st.add(res[i]);
                  });
                }
              }
            }
          });
        });
      });
      _productController.add(st);
      print("st : ${st}");
      return res;
    });
  }

  Future _getCartCount() async {
    var numCart = await DBProvider(dbName: 'Cart').getAllDB();
    for (Order item in numCart) {
      print(item.id);
      print(item.order_quantity);
      print(item.order_product.itemName);
    }
  }
  // REF !!! Streambuilder !!!
  // https://blog.khophi.co/using-refreshindicator-with-flutter-streambuilder/

  // Future<List<Store>> loadData() async {
  //   http.Response response = await http.get(
  //       "http://api.walmartlabs.com/v1/search?apiKey=yvjjwrpu5t9tegghg4a5qs6z&query=healthy&categoryId=976759&start=1&numItems=25");
  //   // http.Response response = await http.get(
  //   //     "https://grocery.walmart.com/v4/api/products/search?storeId=1855&page=1&query=healthy");

  //   Map<String, dynamic> data = json.decode(response.body);
  //   var rest = data['items'] as List;
  //   List<Store> stores = rest.map((json) => Store.fromJson(json)).toList();
  //   for (var i = 0; i < stores.length; i++) {
  //     if (stores[i] == null) {
  //       stores.removeAt(i);
  //     }
  //   }
  //   setState(() {});
  //   return stores;
  // }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        // elevation: 2.0,
        title: Text('Favorites'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return HomeScreen();
              }));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _productController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            print("Data : ${snapshot.data}");
            return ListProductFav(items: snapshot.data);
          } else {
            return Center(child: ProgressDialog());
          }
        },
      ),
      floatingActionButton: ShoppingCart(),
    );
  }
}
