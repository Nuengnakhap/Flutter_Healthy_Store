import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:store_app_proj/tools/app_methods.dart';
import 'package:store_app_proj/tools/favorite_bloc.dart';
import 'package:store_app_proj/tools/firebase_methods.dart';
import 'package:store_app_proj/userScreens/item_details.dart';

class ProductCard extends StatefulWidget {
  Store product;
  bool checked = false;
  bool isLoggedIn;
  ProductCard(
      {Key key,
      @required this.product,
      @required this.checked,
      @required this.isLoggedIn})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  AppMethods appMethod = FirebaseMethods();
  final FavoriteBloc _favoriteBloc = FavoriteBloc();

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
            favoriteButton(),
          ],
        ),
      ),
    );
  }

  Widget favoriteButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      width: 160.0,
      child: Row(
        mainAxisAlignment: widget.isLoggedIn
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "\$${widget.product.itemPrice.toString()}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          widget.isLoggedIn
              ? IconButton(
                  icon: !widget.checked
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
                    if (!widget.checked) {
                      _favoriteBloc.addProductToFavorite(widget.product);
                      widget.checked = true;
                    } else {
                      _favoriteBloc.removeProductofFav(widget.product);
                      widget.checked = false;
                    }
                    setState(() {});
                  },
                )
              : Container(),
        ],
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
