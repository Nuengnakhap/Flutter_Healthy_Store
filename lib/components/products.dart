import 'package:flutter/material.dart';
import 'package:store_app_proj/components/mostrating.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/components/searchbar.dart';
import 'package:store_app_proj/tools/Store.dart';
import 'package:store_app_proj/userScreens/item_details.dart';
import 'dart:math';

class ListProduct extends StatelessWidget {
  List<Store> items;

  ListProduct({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SearchBar(),
              Card(
                  child: MostRating(
                items: items,
              )),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'All products',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
          // HomeScreenTopPart(),
          SliverGrid(
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 175 / 260),
            // itemCount: items.length,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: ProductCard(
                    itemName: items.elementAt(index).itemName,
                    itemImage: items.elementAt(index).itemImage,
                    itemPrice: items.elementAt(index).itemPrice,
                    itemRating: items.elementAt(index).itemRating,
                    itemDesc: items.elementAt(index).itemDesc,
                  ),
                );
              },
              childCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}

// Reference Sliver -> https://benzneststudios.com/blog/flutter/what-is-a-sliver-and-sliver-delegate-in-flutter-ep-1/
// https://medium.com/flutterpub/flutter-listview-gridview-inside-scrollview-68b722ae89d4
