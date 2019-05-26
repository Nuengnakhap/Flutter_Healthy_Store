import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/userScreens/favorites.dart';
import 'package:store_app_proj/userScreens/item_details.dart';

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
  FavoriteBloc _favoriteBloc = FavoriteBloc();

  int click = 0;

  @override
  void initState() {
    super.initState();
    getFav();
    getClick();
  }

  Future getFav() async {
    await Firestore.instance
        .collection('usersData')
        .document(widget.userId)
        .collection('favorites')
        .snapshots()
        .forEach((r) {
      r.documents.forEach((k) async {
        await Firestore.instance
            .collection('usersData')
            .document(widget.userId)
            .collection('favorites')
            .document(k.documentID)
            .get()
            .then((v) {
          setState(() {
            this.favList.add(v['item'].toString());
          });
        });
      });
    });
  }

  Future getClick() {
    _store
        .collection('usersData')
        .document(widget.userId)
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
                      
                      if (click == 0) {
                        _favoriteBloc.addProductToFavorite(widget.product);
                      } else {
                        _favoriteBloc.removeProductofFav(widget.product);
                      }
                      setState(() {
                        click == 0 ? click = 1 : click = 0;
                      });

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
