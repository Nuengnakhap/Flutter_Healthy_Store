import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
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

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
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
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: storeItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ItemDetail(
                              itemName: storeItems[index].itemName,
                              itemImage: storeItems[index].itemImage,
                              itemPrice: storeItems[index].itemPrice,
                              itemRating: storeItems[index].itemRating,
                              itemDesc: storeItems[index].itemDesc,
                              sizeList: storeItems[index].sizeList,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Stack(
                        alignment: FractionalOffset.topLeft,
                        children: <Widget>[
                          Stack(
                            alignment: FractionalOffset.bottomCenter,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(
                                          storeItems[index].itemImage)),
                                ),
                              ),
                              Container(
                                height: 35.0,
                                color: Colors.black.withAlpha(100),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "${storeItems[index].itemName.substring(0, 4)}...",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${storeItems[index].itemPrice} Baht",
                                        style: TextStyle(
                                            color: Colors.red[500],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.blue,
                                      size: 20.0,
                                    ),
                                    Text(
                                      "${storeItems[index].itemRating}",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
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
