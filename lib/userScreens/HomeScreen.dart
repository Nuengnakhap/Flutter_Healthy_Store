import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/components/CustomShapeClipper.dart';
import 'package:store_app_proj/components/products.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/tools/progressdialog.dart';
import 'favorites.dart';
import 'messages.dart';
import 'cart.dart';
import 'notifications.dart';
import 'history.dart';
import 'profile.dart';
import 'delivery.dart';
import 'about.dart';
import 'login.dart';
import '../tools/Store.dart';
import 'item_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  AppMethods appMethod = FirebaseMethods();

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future _asyncMethod() async {
    _client = await DBProvider(dbName: 'Client', cmdInitDB: Client.cmdInitDB)
        .getLasted();
    if (_client != null) {
      acctName = _client.fullName;
      acctEmail = _client.email;
      acctPhotoUrl = _client.photo;
      isLoggedIn = _client.logged;
    } else {
      acctName = 'Guest';
      acctEmail = '';
      acctPhotoUrl = '';
      isLoggedIn = false;
    }
    setState(() {});
  }

  Future<List<Store>> loadData() async {
    http.Response response = await http.get(
        "http://api.walmartlabs.com/v1/search?apiKey=yvjjwrpu5t9tegghg4a5qs6z&query=healthy&categoryId=976759&start=1&numItems=25");
    // http.Response response = await http.get(
    //     "https://grocery.walmart.com/v4/api/products/search?storeId=1855&page=1&query=healthy");
    Map<String, dynamic> data = json.decode(response.body);
    var rest = data['items'] as List;
    List<Store> stores = rest.map((json) => Store.fromJson(json)).toList();
    return stores;
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
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Favorites();
              }));
            },
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chat),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (BuildContext context) {
                    return Messages();
                  }));
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
      body: FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return ListProduct(items: snapshot.data);
          } else {
            return Center(child: ProgressDialog());
          }
        },
      ),
      floatingActionButton: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (BuildContext context) {
                return Cart();
              }));
            },
            child: Icon(Icons.shopping_cart),
          ),
          CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
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
                  return History();
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
    if (response == true) _asyncMethod();
    Navigator.pop(context);
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: CustomShapeClipper(),
        child: Container(
          height: 300.0, color: Colors.teal,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       colors: [firstColor, secondColor],
          //       begin: const FractionalOffset(0.5, 0.0),
          //       end: const FractionalOffset(0.0, 0.5),
          //       stops: [0.0, 1.0],
          //       tileMode: TileMode.clamp),
          // ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Text(
                'What would\nyou want to buy ?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: TextField(
                    controller: search,
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 14.0),
                        border: InputBorder.none,
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0)),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
