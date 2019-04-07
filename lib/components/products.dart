import 'package:flutter/material.dart';
import 'package:store_app_proj/tools/Store.dart';
import 'package:store_app_proj/userScreens/item_details.dart';
import 'dart:math';

class ListProduct extends StatelessWidget {
  List<Store> items;

  ListProduct({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Flexible(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: items.length,
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
                                    items.elementAt(index).itemImage == null
                                        ? ""
                                        : items.elementAt(index).itemImage,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(1, 0.3),
                              child: Container(
                                height: 30.0,
                                width: 60.0,
                                decoration: BoxDecoration(color: Colors.black),
                                child: Center(
                                  child: Text(
                                    "\$${items.elementAt(index).itemPrice == null ? 0 : items.elementAt(index).itemPrice}",
                                    style: TextStyle(
                                        color: Colors.red[500],
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.black.withAlpha(100),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      items.elementAt(index).itemName == null
                                          ? ""
                                          : "${items.elementAt(index).itemName.substring(0, [
                                                items
                                                    .elementAt(index)
                                                    .itemName
                                                    .length,
                                                38
                                              ].reduce(min))}...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0,
                                          color: Colors.white),
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
                                    items.elementAt(index).itemRating == null
                                        ? "0.0"
                                        : items.elementAt(index).itemRating,
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
