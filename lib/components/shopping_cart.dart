
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/tools/cart_bloc.dart';
import 'package:store_app_proj/userScreens/cart.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  final CartBloc _cartBloc = new CartBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      initialData: _cartBloc.currentCart,
      stream: _cartBloc.observableCart,
      builder: (context, snapshot) {
        Cart cart = snapshot.data;
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
                cart.orderCount.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            )
          ],
        );
      }
    );
  }
}
