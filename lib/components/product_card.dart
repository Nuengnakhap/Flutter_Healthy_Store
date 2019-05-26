import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/dbModels/client.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/userScreens/favorites.dart';
import 'package:store_app_proj/userScreens/item_details.dart';
import 'package:store_app_proj/userScreens/login.dart';

class ProductCard extends StatefulWidget {
  Store product;
  int favWant;
  String userId;
  ProductCard({Key key, this.product, this.favWant, this.userId})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  AppMethods appMethod = FirebaseMethods();
  Firestore _store = Firestore.instance;
  List<String> favList = List();
  int click = 0;
  Client _client;
  String acctName = 'Guest';
  String acctEmail = '';
  String acctPhotoUrl = '';
  String uid;
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    _asyncMethod().then((v) {
      getFav();
      getClick();
    });

    print(widget.userId);
    // setState(() {

    // });
  }

  Future _asyncMethod() async {
    _client = await DBProvider(dbName: 'Client').getLasted();
    if (_client != null) {
      setState(() {
        acctName = _client.fullName;
        acctEmail = _client.email;
        acctPhotoUrl = _client.photo;
        isLoggedIn = _client.logged;
        uid = _client.userUID;
      });
    } else {
      setState(() {
        acctName = 'Guest';
        acctEmail = '';
        acctPhotoUrl = '';
        isLoggedIn = false;
        uid = "";
      });
    }
    setState(() {});
  }

  Future getFav() async {
    await Firestore.instance
        .collection('usersData')
        .document(uid)
        .collection('favorites')
        .snapshots()
        .forEach((r) {
      r.documents.forEach((k) {
        Firestore.instance
            .collection('usersData')
            .document(uid)
            .collection('favorites')
            .document(k.documentID)
            .get()
            .then((v) {
          setState(() {
            this.favList.add(v['item'].toString());
          });
          print(v['item']);
        });
      });
    });
  }

  Future getClick() {
    _store
        .collection('usersData')
        .document(uid)
        .collection('favorites')
        .where('item', isEqualTo: "${widget.product.itemName.toString()}")
        .getDocuments()
        .then((onValue) {
      onValue.documents.forEach((f) {
        setState(() {
          click = f['T/F'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int check = 0;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemDetail(
                product: widget.product,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 210.0,
                    width: 160.0,
                    child: Image.network(
                      widget.product.itemImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    // right: 0.0,
                    top: 10.0,
                    left: 10.0,
                    right: 10.0,
                    // width: 150.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.teal, width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: Colors.teal,
                                size: 20.0,
                              ),
                              Text(
                                widget.product.itemRating.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.favorite_border,
                        //     color: Colors.teal,
                        //   ),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 55.0,
                      width: 160.0,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black,
                            Colors.black.withOpacity(0.1)
                          ])),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 55.0,
                      width: 160.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.product.itemName.substring(0, [
                                    widget.product.itemName.length,
                                    30
                                  ].reduce(min))}...",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              width: 160.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "\$${widget.product.itemPrice.toString()}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  IconButton(
                    icon: click == 0
                        ? Icon(
                            Icons.favorite_border,
                            color: Colors.teal,
                            // size: 16.0,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.teal,
                            // size: 16.0,
                          ),
                    onPressed: () {
                      if (acctName == 'Guest') {
                        checkIfLoggedIn();
                      } else {
                        setState(() {
                          click == 0 ? click = 1 : click = 0;
                        });
                        if (favList == null || favList.length == 0) {
                          print(favList);
                          print("1111111");
                          _store
                              .collection("usersData")
                              .document(uid)
                              .collection("favorites")
                              .add({
                            'item': "${widget.product.itemName.toString()}",
                            'T/F': 1
                          });
                        } else {
                          print("22222222");
                          check = 0;
                          for (int i = 0; i < favList.length; i++) {
                            if (favList[i] ==
                                widget.product.itemName.toString()) {
                              _store
                                  .collection("usersData")
                                  .document(uid)
                                  .collection("favorites")
                                  .where('item',
                                      isEqualTo:
                                          "${widget.product.itemName.toString()}")
                                  .getDocuments()
                                  .then((onValue) {
                                onValue.documents.forEach((f) {
                                  _store
                                      .collection("usersData")
                                      .document(uid)
                                      .collection('favorites')
                                      .document(f.documentID)
                                      .setData({
                                    'item': widget.product.itemName.toString(),
                                    'T/F': f['T/F'] == 0 ? 1 : 0
                                  });
                                });
                              });
                              check = 1;
                            }
                          }
                          if (check == 0) {
                            _store
                                .collection("usersData")
                                .document(uid)
                                .collection('favorites')
                                .add({
                              'item': "${widget.product.itemName.toString()}",
                              'T/F': 1
                            });
                          }
                        }

                        if (widget.favWant == 1) {
                          Navigator.of(context).push(
                              NoAnimationMaterialPageRoute(
                                  builder: (BuildContext context) {
                            return FavoritesScreen();
                          }));
                        }
                      }
                    },
                  ),
                ],
              ),
            )
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

class NoAnimationMaterialPageRoute<T> extends CupertinoPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
