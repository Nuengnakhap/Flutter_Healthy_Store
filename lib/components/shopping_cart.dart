import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/tools/app_db.dart';
import 'package:store_app_proj/userScreens/cart.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  int numCart;

  @override
  void initState() {
    super.initState();
    noCart();
  }

  @override
  void setState(fn) {
    DBProvider(dbName: 'Cart').getAllDB().then((res) {
      numCart = res.length;
    });
    super.setState(fn);
  }
  void noCart() async {
    await DBProvider(dbName: 'Cart').getAllDB().then((res) {
      numCart = res.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (BuildContext context) {
              return CartScreen();
            }));
          },
          child: Icon(Icons.shopping_cart),
        ),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.red,
          child: Text(
            numCart.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        )
      ],
    );
  }
}
