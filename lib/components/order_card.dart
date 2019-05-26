import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'dart:math';

import 'package:store_app_proj/tools/cart_bloc.dart';

class OrderWidget extends StatefulWidget {
  final Order _order;
  OrderWidget(this._order);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final CartBloc _cartBloc = new CartBloc();

  // int _quantity = widget._order.order_quantity;

  void _increase() {
    setState(() {
      widget._order.order_quantity++;
    });
    _cartBloc.updateOrderOfCart(widget._order);
  }

  void _decrease() {
    setState(() {
      if (widget._order.order_quantity > 1) widget._order.order_quantity--;
    });
    _cartBloc.updateOrderOfCart(widget._order);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    //color: color,
                    image: DecorationImage(
                      image:
                          NetworkImage(widget._order.order_product.itemImage),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "${widget._order.order_product.itemName.substring(0, [
                                  widget._order.order_product.itemName.length,
                                  30
                                ].reduce(min))}..."),
                        const Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Text(
                          "\$" +
                              widget._order.order_product.itemPrice
                                  .toStringAsFixed(2),
                          style: const TextStyle(
                            color: const Color(0xFF8E8E93),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    CupertinoIcons.minus_circled,
                    semanticLabel: 'Substract',
                  ),
                  onPressed: _decrease,
                  // () {
                  //   // removeQuantity(fbconn.getKeyIDasList()[index],
                  //   //     fbconn.getItemQuantityAsList()[index]);
                  // },
                ),
                Text(
                  widget._order.order_quantity.toString(),
                  style: const TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    CupertinoIcons.plus_circled,
                    semanticLabel: 'Add',
                  ),
                  onPressed: _increase,
                  // () {
                    // addQuantity(fbconn.getKeyIDasList()[index],
                    //     fbconn.getItemQuantityAsList()[index]);
                  // },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _cartBloc.removerOrderOfCart(widget._order);
                    /* showInSnackBar(fbconn.getProductNameAsList()[index] +
                              " has been removed");
                          setState(() {});*/
                  },
                  child: Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.remove_shopping_cart,
                              size: 18.0,
                            ),
                          ),
                          Text(
                            "REMOVE",
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.black12,
                  margin: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    /* showInSnackBar(fbconn.getProductNameAsList()[index] +
                              " has been added to your favorites");
                          setState(() {});*/
                  },
                  child: Container(
                    width: 120.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.favorite_border,
                              size: 18.0,
                            ),
                          ),
                          Text(
                            "ADD TO FAVORITES",
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
