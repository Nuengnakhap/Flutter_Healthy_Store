import 'package:flutter/material.dart';
import 'package:store_app_proj/components/mostrating.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/components/searchbar.dart';
import 'package:store_app_proj/dbModels/Store.dart';

class ListProduct extends StatefulWidget {
  List<Store> items;
  String userId;
  ListProduct({Key key, this.items, this.userId}) : super(key: key);

  @override
  ListProductState createState() => ListProductState();
}

class ListProductState extends State<ListProduct> {
  int favWant = 0;
  @override
  Widget build(BuildContext context) {
    List<Store> items = widget.items;
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SearchBar(items: items),
              Card(
                child: MostRating(
                  items: items,
                ),
              ),
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
                    product: Store.items(
                      itemName: items.elementAt(index).itemName,
                      itemImage: items.elementAt(index).itemImage,
                      itemPrice: items.elementAt(index).itemPrice,
                      itemRating: items.elementAt(index).itemRating,
                      itemDesc: items.elementAt(index).itemDesc,
                    ),
                    favWant: favWant,
                    userId: widget.userId,
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
