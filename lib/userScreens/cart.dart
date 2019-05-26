import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/components/order_card.dart';
import 'package:store_app_proj/dbModels/cart.dart';
import 'package:store_app_proj/tools/cart_bloc.dart';
import 'dart:math';

import 'package:store_app_proj/userScreens/credit_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        initialData: _cartBloc.currentCart,
        stream: _cartBloc.observableCart,
        builder: (context, AsyncSnapshot<Cart> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 8.0,
                right: 8.0,
                bottom: 2.0,
              ),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "ITEMS (${snapshot.data.orderCount})",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "TOTAL : \$${snapshot.data.totalPrice().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.orderCount,
                      itemBuilder: (context, index) {
                        return OrderWidget(snapshot.data.orders[index]);
                      },
                    ),
                  ),
                  Container(
                    height: 50.0,
                    color: Colors.white,
                    child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCardPage()));
                        },
                        child: new Container(
                          width: double.infinity,
                          margin: new EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 2.0),
                          height: 50.0,
                          decoration: new BoxDecoration(
                              color: Colors.teal,
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(5.0))),
                          child: new Center(
                              child: new Text(
                            "PROCEED TO PAYMENT",
                            style: new TextStyle(
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Cart is empty'),
            );
          }
        },
      ),
    );
  }
}
