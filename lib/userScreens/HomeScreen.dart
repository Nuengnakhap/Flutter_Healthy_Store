import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/components/products.dart';
import 'package:store_app_proj/components/shopping_cart.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/cart_bloc.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/tools/progressdialog.dart';
import 'package:store_app_proj/userScreens/order_history.dart';
import 'favorites.dart';
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  List<String> favList = List();
  AppMethods appMethod = FirebaseMethods();

  CartBloc _cartBloc = CartBloc();

  StreamController _productController;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    _productController = StreamController();
    loadProducts();
    getIdAdmin();
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

  loadProducts() async {
    await fetchProduct().then((res) async {
      _productController.add(res);
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

  Future getIdAdmin() async {
    await Firestore.instance.collection('usersData').snapshots().forEach((r) {
      r.documents.forEach((r) {
        Firestore.instance
            .collection('usersData')
            .document(r.documentID)
            .get()
            .then((v) {
          if (v['acctFullName'] == 'admin') {
            adminId = v['userID'];
          }
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        // elevation: 2.0,
        title: Text('Healthies'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              if (acctName == 'Guest') {
                checkIfLoggedIn();
              } else {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return FavoritesScreen();
                }));
              }
            },
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chat),
                color: Colors.white,
                onPressed: () {
                  print(userId);
                  if (userId == adminId) {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return AdminScreen(
                        adminId: adminId,
                        userId: adminId,
                        peerAvatar: "",
                      );
                    }));
                  } else if (acctName == 'Guest') {
                    checkIfLoggedIn();
                  } else {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (BuildContext context) {
                      return Chat(
                        peerId: adminId,
                        userId: userId,
                        peerAvatar: "",
                      );
                    }));
                  }
                },
              ),
              CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream: _productController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return ListProduct(items: snapshot.data, userId: userId);
          } else {
            return Center(child: ProgressDialog());
          }
        },
      ),
      floatingActionButton: ShoppingCart(),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              accountName: Text(acctName.toString()),
              accountEmail: Text(acctEmail.toString()),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Order Notifications'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Notifications();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Order History'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return OrderHistory();
                }));
              },
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Profile Settings'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Profile();
                }));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('Delivery Address'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return Delivery();
                }));
              },
            ),
            Divider(),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: Text('About Us'),
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (BuildContext context) {
                  return About();
                }));
              },
            ),
            ListTile(
              trailing: CircleAvatar(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              title: isLoggedIn == true ? Text('Logout') : Text('Login'),
              onTap: () async {
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (BuildContext context,
                //         Animation<double> animation,
                //         Animation<double> secondaryAnimation) {
                //       return Login();
                //     },
                //     transitionsBuilder: (BuildContext context,
                //         Animation<double> animation,
                //         Animation<double> secondaryAnimation,
                //         Widget child) {
                //       return SlideTransition(
                //         position: Tween<Offset>(
                //           begin: Offset(0.0, 1.0),
                //           end: Offset(0.0, 0.0),
                //         ).animate(animation),
                //         child: child,
                //       );
                //     },
                //     // transitionDuration: Duration(seconds: 3),
                //   ),
                // );
                checkIfLoggedIn();
              },
            ),
          ],
        ),
      ),
    );
  }

  checkIfLoggedIn() async {
    if (isLoggedIn == false) {
      bool response = await Navigator.of(context)
          .push(CupertinoPageRoute(builder: (BuildContext context) => Login()));
      if (response == true) _asyncMethod();
      return;
    }
    bool response = await appMethod.logoutUser();
    if (response == true) {
      _asyncMethod();
      _cartBloc.clearCart();
    }
    Navigator.pop(context);
  }
}
