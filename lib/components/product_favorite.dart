import 'package:flutter/material.dart';
import 'package:store_app_proj/components/product_card.dart';
import 'package:store_app_proj/dbModels/Store.dart';
import 'package:store_app_proj/dbModels/favorite.dart';

class ListProductFav extends StatefulWidget {
  Favorite items;

  ListProductFav({Key key, this.items}) : super(key: key);

  @override
  ListProductFavState createState() => ListProductFavState();
}

class ListProductFavState extends State<ListProductFav> {
  @override
  Widget build(BuildContext context) {
    List<Store> items;
    setState(() {
      items = widget.items.products;
    });
    MediaQueryData queryData  = MediaQuery.of(context);
    return Center(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Favorite products',
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
                crossAxisCount: 2, childAspectRatio: (queryData.size.width/2)/270),
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
                    checked: true,
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
