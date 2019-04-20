import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app_proj/dbModels/order.dart';
import 'dart:math';

class OrderWidget extends StatelessWidget {
  final Order _order;
  OrderWidget(this._order);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
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
                      image: NetworkImage(_order.order_product.itemImage),
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
                        Text("${_order.order_product.itemName.substring(0, [
                              _order.order_product.itemName.length,
                              30
                            ].reduce(min))}..."),
                        const Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Text(
                          "\$" +
                              _order.order_product.itemPrice.toStringAsFixed(2),
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
                  onPressed: () {
                    // removeQuantity(fbconn.getKeyIDasList()[index],
                    //     fbconn.getItemQuantityAsList()[index]);
                  },
                ),
                Text(
                  _order.order_quantity.toString(),
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
                  onPressed: () {
                    // addQuantity(fbconn.getKeyIDasList()[index],
                    //     fbconn.getItemQuantityAsList()[index]);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      /* showInSnackBar(fbconn.getProductNameAsList()[index] +
                                " has been removed");
                            setState(() {});*/
                    },
                    child: Container(
                      width: 120.0,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
